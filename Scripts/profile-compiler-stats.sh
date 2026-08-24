#!/usr/bin/env bash
set -euo pipefail

STATS_DIR="_diagnostics/stats"

echo "=== Cleaning build directory and previous diagnostics ==="
rm -rf "${STATS_DIR}" .build
mkdir -p "${STATS_DIR}"

echo "=== Building project with compiler statistics enabled ==="
swift build --disable-sandbox -Xswiftc -stats-output-dir -Xswiftc "${STATS_DIR}"

echo "=== Analyzing compiler stats ==="
python3 - "${STATS_DIR}" << 'EOF'
import json
import glob
import os
import sys

stats_dir = sys.argv[1]
json_files = glob.glob(os.path.join(stats_dir, "stats-*.json"))

if not json_files:
    print(f"No stat JSON files found in {stats_dir}")
    sys.exit(1)

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
            
            # Sema / Type checking time
            tc_wall = data.get("time.swift.perform-whole-module-type-checking.wall", 0.0)
            if tc_wall == 0.0:
                tc_wall = data.get("time.swift.perform-sema.wall", 0.0)
            if tc_wall == 0.0:
                tc_wall = data.get("time.swift.Type checking and Semantic analysis.wall", 0.0)
                
            sil_wall = data.get("time.swift.SILGen.wall", 0.0)
            
            # Find frontend wall key
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
            # Find swift file name from JSON filename if present
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
        print(f"Error reading {filepath}: {e}")

# Sort by instructions descending
frontend_stats.sort(key=lambda x: x["instructions"], reverse=True)

print("\n--------------------------------------------------------------------------------")
print(f"{'Swift File':<40} | {'Instructions':<15} | {'Lines':<8} | {'Sema Wall (s)':<12}")
print("--------------------------------------------------------------------------------")
for item in frontend_stats[:10]:
    print(f"{item['file']:<40} | {item['instructions']:>15,} | {item['lines']:>8,} | {item['tc_wall']:>12.3f}")

print("--------------------------------------------------------------------------------")
print("Compiler Statistics Summary:")
print("--------------------------------------------------")
print(f"Total Instructions Executed : {total_instructions:,}")
print(f"Total AST Source Lines      : {total_source_lines:,}")
if total_source_lines > 0:
    print(f"Instructions / Source Line  : {total_instructions / total_source_lines:,.1f}")
print(f"Type-Checking Wall Time    : {total_typechecking_wall:.3f} s")
print(f"Total Frontend Wall Time    : {total_frontend_wall:.3f} s")
print(f"SILGen Wall Time            : {total_silgen_wall:.3f} s")
print("--------------------------------------------------\n")
EOF
