#!/usr/bin/env python3
import subprocess
import json
import glob
import os
import sys
import argparse

def main():
    parser = argparse.ArgumentParser(description="Benchmark compiler stats across git commits.")
    parser.add_argument("--base", default="origin/master", help="Base commit or branch to start benchmark from")
    parser.add_argument("--runs", type=int, default=2, help="Number of benchmark runs per commit")
    parser.add_argument("--output", default="_diagnostics/commit_stats_multi.json", help="Path to output JSON result file")
    args = parser.parse_args()

    # Determine root directory of git repository
    repo_root = subprocess.check_output(["git", "rev-parse", "--show-toplevel"], text=True).strip()
    os.chdir(repo_root)

    profile_script = os.path.join(repo_root, "Scripts", "profile-compiler-stats.sh")
    if not os.path.exists(profile_script):
        print(f"Error: Profile script not found at {profile_script}")
        sys.exit(1)

    # Get current branch
    current_branch = subprocess.check_output(["git", "rev-parse", "--abbrev-ref", "HEAD"], text=True).strip()

    # Get commits from base to HEAD
    try:
        log_output = subprocess.check_output(
            ["git", "log", f"{args.base}..HEAD", "--oneline", "--reverse"],
            text=True
        ).strip()
    except subprocess.CalledProcessError as e:
        print(f"Error fetching git commit log: {e}")
        sys.exit(1)

    commits = [(args.base, f"Baseline ({args.base})")]
    if log_output:
        for line in log_output.splitlines():
            parts = line.split(" ", 1)
            sha = parts[0]
            msg = parts[1] if len(parts) > 1 else ""
            commits.append((sha, msg))

    results = []

    try:
        for commit_sha, commit_msg in commits:
            print(f"\n==================================================")
            print(f"Checking out {commit_sha}: {commit_msg}")
            print(f"==================================================")
            
            subprocess.run(["git", "checkout", "-f", commit_sha], check=True)
            
            runs = []
            for run_idx in range(1, args.runs + 1):
                print(f"--- Run {run_idx}/{args.runs} for {commit_sha} ---")
                
                res = subprocess.run([profile_script], stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
                
                stats_dir = "_diagnostics/stats"
                json_files = glob.glob(os.path.join(stats_dir, "stats-*.json"))
                
                total_instructions = 0
                total_source_lines = 0
                total_typechecking_wall = 0.0
                total_silgen_wall = 0.0
                total_frontend_wall = 0.0
                
                frontend_stats = []
                
                for filepath in json_files:
                    try:
                        with open(filepath, 'r') as f:
                            data = json.load(f)
                            
                            instructions = data.get("Frontend.NumInstructionsExecuted", 0)
                            lines = data.get("AST.NumSourceLines", 0)
                            
                            tc_wall = data.get("time.swift.perform-whole-module-type-checking.wall", 0.0)
                            if tc_wall == 0.0:
                                tc_wall = data.get("time.swift.perform-sema.wall", 0.0)
                            if tc_wall == 0.0:
                                tc_wall = data.get("time.swift.Type checking and Semantic analysis.wall", 0.0)
                                
                            sil_wall = data.get("time.swift.SILGen.wall", 0.0)
                            
                            fe_wall = 0.0
                            for k, v in data.items():
                                if k.startswith("time.swift-frontend.") and k.endswith(".wall"):
                                    fe_wall = v
                                    break
                            
                            total_instructions += instructions
                            total_source_lines += lines
                            total_typechecking_wall += tc_wall
                            total_silgen_wall += sil_wall
                            total_frontend_wall += fe_wall
                            
                            filename = os.path.basename(filepath)
                            parts = filename.split("swift-frontend-FirebladeMath-")
                            swift_file = parts[1].split("-arm64")[0] if len(parts) > 1 else filename
                            
                            if instructions > 0:
                                frontend_stats.append({
                                    "file": swift_file,
                                    "instructions": instructions,
                                    "lines": lines,
                                    "tc_wall": tc_wall,
                                    "fe_wall": fe_wall
                                })
                    except Exception as e:
                        print(f"Error parsing {filepath}: {e}")
                        
                frontend_stats.sort(key=lambda x: x["instructions"], reverse=True)
                
                runs.append({
                    "run_index": run_idx,
                    "total_instructions": total_instructions,
                    "total_source_lines": total_source_lines,
                    "typechecking_wall": total_typechecking_wall,
                    "frontend_wall": total_frontend_wall,
                    "silgen_wall": total_silgen_wall,
                    "top_hotspots": frontend_stats[:5]
                })
            
            avg_instructions = sum(r["total_instructions"] for r in runs) / len(runs) if runs else 0
            avg_frontend_wall = sum(r["frontend_wall"] for r in runs) / len(runs) if runs else 0
            
            results.append({
                "commit_sha": commit_sha,
                "commit_msg": commit_msg,
                "runs": runs,
                "avg_instructions": avg_instructions,
                "avg_frontend_wall": avg_frontend_wall
            })

    finally:
        # Always restore original branch
        subprocess.run(["git", "checkout", "-f", current_branch], check=True)

    os.makedirs(os.path.dirname(os.path.abspath(args.output)), exist_ok=True)
    with open(args.output, 'w') as f:
        json.dump(results, f, indent=2)

    print(f"\nBenchmarking complete. Saved results to {args.output}")

if __name__ == "__main__":
    main()
