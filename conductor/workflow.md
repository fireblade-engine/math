# Project Workflow

## Guiding Principles

0. **Protocol is Supreme (Protocol Over Speed):** Speed is irrelevant if it leads to error. Accuracy, thoroughness, and strict adherence to protocol are the only metrics of success. **NEVER** prioritize speed over verification. **NEVER** assume the state of the system; always verify it explicitly (e.g., `git status`, `ls`, file reads) before acting.
1. **The Plan is the Source of Truth:** All work must be tracked in `plan.md`
2. **Dedicated Branching:** Every track MUST be developed on its own dedicated git branch (e.g., `track/shortname_YYYYMMDD`).
3. **The Tech Stack is Deliberate:** Changes to the tech stack must be documented in `tech-stack.md` *before* implementation
4. **Strict Test Success Policy:** ALL tests must run and be successful before a track can be finished. No exceptions.
5. **Test-Driven Development:** Write unit tests before implementing functionality
6. **High Code Coverage:** Aim for >80% code coverage for all modules
7. **User Experience First:** Every decision should prioritize user experience
8. **Non-Interactive & CI-Aware:** Prefer non-interactive commands. Use `CI=true` for watch-mode tools (tests, linters) to ensure single execution.

## Universal File Resolution Protocol

**PROTOCOL: How to locate files.**
To find a file (e.g., "**Product Definition**") within a specific context (Project Root or a specific Track):

1.  **Identify Index:** Determine the relevant index file:
    -   **Project Context:** `conductor/index.md`
    -   **Track Context:**
        a. Resolve and read the **Tracks Registry** (via Project Context).
        b. Find the entry for the specific `<track_id>`.
        c. Follow the link provided in the registry to locate the track's folder. The index file is `<track_folder>/index.md`.
        d. **Fallback:** If the track is not yet registered (e.g., during creation) or the link is broken:
            1. Resolve the **Tracks Directory** (via Project Context).
            2. The index file is `<Tracks Directory>/<track_id>/index.md`.

2.  **Check Index:** Read the index file and look for a link with a matching or semantically similar label.

3.  **Resolve Path:** If a link is found, resolve its path **relative to the directory containing the `index.md` file**.
    -   *Example:* If `conductor/index.md` links to `./workflow.md`, the full path is `conductor/workflow.md`.

4.  **Fallback:** If the index file is missing or the link is absent, use the **Default Path** keys below.

5.  **Verify:** You MUST verify the resolved file actually exists on the disk.

**Standard Default Paths (Project):**
- **Product Definition**: `conductor/product.md`
- **Tech Stack**: `conductor/tech-stack.md`
- **Workflow**: `conductor/workflow.md`
- **Product Guidelines**: `conductor/product-guidelines.md`
- **Tracks Registry**: `conductor/tracks.md`
- **Tracks Directory**: `conductor/tracks/`

**Standard Default Paths (Track):**
- **Specification**: `conductor/tracks/<track_id>/spec.md`
- **Implementation Plan**: `conductor/tracks/<track_id>/plan.md`
- **Metadata**: `conductor/tracks/<track_id>/metadata.json`

## Task Workflow

All tasks follow a strict lifecycle:

### Standard Task Workflow

0. **Initialize Track Branch:** Before any work begins, create and switch to a new branch for the track: `git checkout -b track/<track_id>`.

1. **Select Task:** Choose the next available task from `plan.md` in sequential order

2. **Mark In Progress:** Before beginning work, edit `plan.md` and change the task from `[ ]` to `[~]`

3. **Write Failing Tests (Red Phase):**
   - Create a new test file for the feature or bug fix.
   - Write one or more unit tests that clearly define the expected behavior and acceptance criteria for the task.
   - **CRITICAL:** Run the tests and confirm that they fail as expected. This is the "Red" phase of TDD. Do not proceed until you have failing tests.

4. **Implement to Pass Tests (Green Phase):**
   - Write the minimum amount of application code necessary to make the failing tests pass.
   - Run the test suite again and confirm that all tests now pass. This is the "Green" phase.

5. **Refactor (Optional but Recommended):**
   - With the safety of passing tests, refactor the implementation code and the test code to improve clarity, remove duplication, and enhance performance without changing the external behavior.
   - Rerun tests to ensure they still pass after refactoring.

6. **Verify Coverage:** Run coverage reports using the project's chosen tools. For example, in a Python project, this might look like:
   ```bash
   pytest --cov=app --cov-report=html
   ```
   Target: >80% coverage for new code. The specific tools and commands will vary by language and framework.

7. **Document Deviations:** If implementation differs from tech stack:
   - **STOP** implementation
   - Update `tech-stack.md` with new design
   - Add dated note explaining the change
   - Resume implementation

8. **Commit Code Changes:**
   - Stage all code changes related to the task.
   - Propose a clear, concise commit message e.g, `feat(ui): Create basic HTML structure for calculator`.
   - Perform the commit.

9. **Attach Task Summary with Git Notes:**
   - **Step 9.1: Get Commit Hash:** Obtain the hash of the *just-completed commit* (`git log -1 --format="%H"`).
   - **Step 9.2: Draft Note Content:** Create a detailed summary for the completed task. This should include the task name, a summary of changes, a list of all created/modified files, and the core "why" for the change.
   - **Step 9.3: Attach Note:** Use the `git notes` command to attach the summary to the commit.
     ```bash
     # The note content from the previous step is passed via the -m flag.
     git notes add -m "<note content>" <commit_hash>
     ```

10. **Get and Record Task Commit SHA:**
    - **Step 10.1: Update Plan:** Read `plan.md`, find the line for the completed task, update its status from `[~]` to `[x]`, and append the first 7 characters of the *just-completed commit's* commit hash.
    - **Step 10.2: Write Plan:** Write the updated content back to `plan.md`.

11. **Commit Plan Update:**
    - **Action:** Stage the modified `plan.md` file.
    - **Action:** Commit this change with a descriptive message (e.g., `conductor(plan): Mark task 'Create user model' as complete`).

### Phase Completion Verification and Checkpointing Protocol

**Trigger:** This protocol is executed immediately after a task is completed that also concludes a phase in `plan.md`.

1.  **Announce Protocol Start:** Inform the user that the phase is complete and the verification and checkpointing protocol has begun.

2.  **Ensure Test Coverage for Phase Changes:**
    -   **Step 2.1: Determine Phase Scope:** To identify the files changed in this phase, you must first find the starting point. Read `plan.md` to find the Git commit SHA of the *previous* phase's checkpoint. If no previous checkpoint exists, the scope is all changes since the first commit.
    -   **Step 2.2: List Changed Files:** Execute `git diff --name-only <previous_checkpoint_sha> HEAD` to get a precise list of all files modified during this phase.
    -   **Step 2.3: Verify and Create Tests:** For each file in the list:
        -   **CRITICAL:** First, check its extension. Exclude non-code files (e.g., `.json`, `.md`, `.yaml`).
        -   For each remaining code file, verify a corresponding test file exists.
        -   **TESTING FRAMEWORK:** Use ONLY the `Testing` module (Swift 6). `XCTest` is **NOT ALLOWED**.
        -   If a test file is missing, you **must** create one. Before writing the test, **first, analyze other test files in the repository to determine the correct naming convention and testing style.** The new tests **must** validate the functionality described in this phase's tasks (`plan.md`).

3.  **Execute Automated Tests with Proactive Debugging:**
    -   Before execution, you **must** announce the exact shell command you will use to run the tests.
    -   **Example Announcement:** "I will now run the automated test suite to verify the phase. **Command:** `CI=true npm test`"
    -   Execute the announced command.
    -   If tests fail, you **must** inform the user and begin debugging. You may attempt to propose a fix a **maximum of two times**. If the tests still fail after your second proposed fix, you **must stop**, report the persistent failure, and ask the user for guidance.

4.  **Propose a Detailed, Actionable Manual Verification Plan:**
    -   **CRITICAL:** To generate the plan, first analyze `product.md`, `product-guidelines.md`, and `plan.md` to determine the user-facing goals of the completed phase.
    -   You **must** generate a step-by-step plan that walks the user through the verification process, including any necessary commands and specific, expected outcomes.
    -   The plan you present to the user **must** follow this format:

        **For a Frontend Change:**
        ```
        The automated tests have passed. For manual verification, please follow these steps:

        **Manual Verification Steps:**
        1.  **Start the development server with the command:** `npm run dev`
        2.  **Open your browser to:** `http://localhost:3000`
        3.  **Confirm that you see:** The new user profile page, with the user's name and email displayed correctly.
        ```

        **For a Backend Change:**
        ```
        The automated tests have passed. For manual verification, please follow these steps:

        **Manual Verification Steps:**
        1.  **Ensure the server is running.**
        2.  **Execute the following command in your terminal:** `curl -X POST http://localhost:8080/api/v1/users -d '{"name": "test"}'`
        3.  **Confirm that you receive:** A JSON response with a status of `201 Created`.
        ```

5.  **Await Explicit User Feedback:**
    -   After presenting the detailed plan, ask the user for confirmation: "**Does this meet your expectations? Please confirm with yes or provide feedback on what needs to be changed.**"
    -   **PAUSE** and await the user's response. Do not proceed without an explicit yes or confirmation.

6.  **Create Checkpoint Commit:**
    -   Stage all changes. If no changes occurred in this step, proceed with an empty commit.
    -   Perform the commit with a clear and concise message (e.g., `conductor(checkpoint): Checkpoint end of Phase X`).

7.  **Attach Auditable Verification Report using Git Notes:**
    -   **Step 7.1: Draft Note Content:** Create a detailed verification report including the automated test command, the manual verification steps, and the user's confirmation.
    -   **Step 7.2: Attach Note:** Use the `git notes` command and the full commit hash from the previous step to attach the full report to the checkpoint commit.

8.  **Get and Record Phase Checkpoint SHA:**
    -   **Step 8.1: Get Commit Hash:** Obtain the hash of the *just-created checkpoint commit* (`git log -1 --format="%H"`).
    -   **Step 8.2: Update Plan:** Read `plan.md`, find the heading for the completed phase, and append the first 7 characters of the commit hash in the format `[checkpoint: <sha>]`.
    -   **Step 8.3: Write Plan:** Write the updated content back to `plan.md`.

9. **Commit Plan Update:**
    - **Action:** Stage the modified `plan.md` file.
    - **Action:** Commit this change with a descriptive message following the format `conductor(plan): Mark phase '<PHASE NAME>' as complete`.

10.  **Announce Completion:** Inform the user that the phase is complete and the checkpoint has been created, with the detailed verification report attached as a git note.

### Snapshot Testing Protocol (The Gold Standard)

1.  **Verification:** Every visual change MUST be verified via snapshot tests.
2.  **Zero Re-recording Policy:** I am ABSOLUTELY PROHIBITED from re-recording snapshot tests that are already committed to git.
3.  **Regressions:** If a code change leads to a non-matching snapshot, I MUST assume the implementation is incorrect or requires adjustment to maintain visual parity. I will fix the code, not the snapshot.
4.  **User Authority:** Only the user is allowed to authorize or perform the re-recording of snapshots.
5.  **Manual Verification:** Before requesting approval for a phase involving snapshots, I must provide the file paths of any failing tests for manual inspection.

### Track Completion Protocol

**Trigger:** This protocol is executed when all tasks and phases in a track's `plan.md` are marked as complete.

1. **Clean Project State Verification:**
   - **Objective:** Ensure the repository is in a clean state with no uncommitted changes or untracked temporary files.
   - **Action:** Execute `git status`.
   - **Verification:**
     - If `git status` reports "working tree clean", proceed.
     - If untracked files exist:
       - **CRITICAL:** Check for Conductor track files (`spec.md`, `metadata.json`, `index.md`, `plan.md`). These **MUST** be committed to preserve track history.
       - Determine if they are temporary/garbage (e.g., test outputs, temp logs). If so, **remove them**.
       - Determine if they are artifacts that should be ignored. If so, **add them to `.gitignore`**.
       - Determine if they are valuable. If so, **commit them**.
     - If uncommitted changes exist:
       - **Commit them** if they are part of the work.
       - **Discard them** if they are accidental (confirm with user).
   - **Final Check:** Run `git status` again to confirm "nothing to commit, working tree clean".

2. **Merge to Main:**
   - **Objective:** Integrate the completed track into the stable `main` branch.
   - **Action:** After the **Final Verification Protocol** is complete and the user has provided explicit confirmation, the track branch MUST be merged into `main`.
   - **Constraint:** The merge MUST be performed as a single, squashed commit.
   - **Command:** `git checkout main && git merge --squash track/<track_id> && git commit -m "<type>(<track_id>): <Final Summary>"`
   - **Post-Merge:** Delete the track branch: `git branch -D track/<track_id>`.

### Final Verification Protocol

**Trigger:** This protocol MUST be executed as the absolute final step before marking any track as complete.

1.  **Build/Run Mandate:**
    -   You MUST execute a full build of the project using the standardized command: `make build`.
    -   If the track involved a specific example or executable (e.g., `HelloCube`), you MUST run it: `make run-example app=<ExecutableName>`.
    -   **CRITICAL:** If the build or run fails, you CANNOT finish the track. You must fix the issues and repeat this step.

2.  **Zero Compiler Warnings & Zero Vulkan Validation Errors:**
    -   You MUST inspect the build and test output for warnings and validation errors.
    -   **BLOCKING:** Any Swift compiler warning (e.g., "variable was never mutated", "result of call is unused") must be treated as an error and fixed before proceeding.
    -   **BLOCKING:** Any Vulkan Validation Error or Warning (e.g., from `VK_LAYER_KHRONOS_validation`) must be treated as a hard failure and fixed before proceeding.
    -   Exceptions: Warnings from 3rd-party dependencies (in `Sources/Packages`) are acceptable if fixing them is out of scope, but project code and Vulkan usage must be clean.

3.  **User Validation Loop:**
    -   After a successful build/run, you MUST present the results to the user.
    -   You MUST ask: "**Does this meet your expectations? Please confirm with yes or provide feedback on what needs to be changed.**"
    -   **BLOCKING:** You CANNOT proceed to "Track Cleanup" or mark the track as `[x]` until the user provides an explicit "Yes" or confirmation.

3.  **Rejection Handling:**
    -   If the user replies "No" or provides feedback, you MUST:
        a.  Acknowledge the feedback.
        b.  Identify the necessary corrections.
        c.  Implement the fixes.
        d.  Restart this "Final Verification Protocol" from Step 1.

### Quality Gates

Before marking any task complete, verify:

- [ ] All tests pass
- [ ] Snapshot tests pass and have been visually verified (if changed)
- [ ] Code coverage meets requirements (>80%)
- [ ] Code follows project's code style guidelines (as defined in `code_styleguides/` and `product-guidelines.md`)
- [ ] **Strict Swift Standards followed:**
    - [ ] No Objective-C or `NS*` APIs used (Pure Swift only)
    - [ ] Error enums defined in extensions: `extension <TYPE> { enum Error ... }`
    - [ ] No `try!` or `try?` used (explicit `do-catch` only)
    - [ ] Inner types defined in extensions: `extension <OUTER> { struct <INNER> ... }`
- [ ] All public functions/methods are documented (e.g., docstrings, JSDoc, GoDoc)
- [ ] Type safety is enforced (e.g., type hints, TypeScript types, Go types)
- [ ] No linting or static analysis errors (using the project's configured tools)
- [ ] No fatalError usage
- [ ] No Vulkan Validation Errors or Warnings
- [ ] Works correctly on mobile (if applicable)
- [ ] Documentation updated if needed
- [ ] No security vulnerabilities introduced


## Development Commands

### Setup
*Prerequisite: Xcode 26.2+ (macOS) or Swift 6.2+ Toolchain.*
```bash
make setup
```

### Daily Development
```bash
# Build
make build

# Run (e.g. Firestorm or Example)
make run-example app=Firestorm

# Test
make test

# Lint & Format
make lint-fix
```

### Before Committing
```bash
# Run all checks: empty dir cleanup, linting, and tests (w/ warnings as errors)
make pre-commit
```


## Testing Requirements

### Unit Testing
- Every module must have corresponding tests.
- Use appropriate test setup/teardown mechanisms (e.g., fixtures, beforeEach/afterEach).
- Mock external dependencies.
- Test both success and failure cases.

### Integration Testing
- Test complete user flows
- Verify database transactions
- Test authentication and authorization
- Check form submissions

### Mobile Testing
- Test on actual iPhone when possible
- Use Safari developer tools
- Test touch interactions
- Verify responsive layouts
- Check performance on 3G/4G

## Code Review Process

### Self-Review Checklist
Before requesting review:

1. **Functionality**
   - Feature works as specified
   - Edge cases handled
   - Error messages are user-friendly

2. **Code Quality**
   - Follows style guide
   - DRY principle applied
   - Clear variable/function names
   - Appropriate comments

3. **Testing**
   - Unit tests comprehensive
   - Integration tests pass
   - Coverage adequate (>80%)

4. **Security**
   - No hardcoded secrets
   - Input validation present
   - SQL injection prevented
   - XSS protection in place

5. **Performance**
   - Database queries optimized
   - Images optimized
   - Caching implemented where needed

6. **Mobile Experience**
   - Touch targets adequate (44x44px)
   - Text readable without zooming
   - Performance acceptable on mobile
   - Interactions feel native

## Commit Guidelines

### Message Format
```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Types
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Formatting, missing semicolons, etc.
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `test`: Adding missing tests
- `chore`: Maintenance tasks

### Examples
```bash
git commit -m "feat(auth): Add remember me functionality"
git commit -m "fix(posts): Correct excerpt generation for short posts"
git commit -m "test(comments): Add tests for emoji reaction limits"
git commit -m "style(mobile): Improve button touch targets"
```

## Definition of Done

A task is complete when:

1. All code implemented to specification
2. Unit tests written and passing
3. Code coverage meets project requirements
4. Documentation complete (if applicable)
5. Code passes all configured linting and static analysis checks
6. Works beautifully on mobile (if applicable)
7. Implementation notes added to `plan.md`
8. Changes committed with proper message
9. Git note with task summary attached to the commit

## Emergency Procedures

### Critical Bug in Production
1. Create hotfix branch from main
2. Write failing test for bug
3. Implement minimal fix
4. Test thoroughly including mobile
5. Deploy immediately
6. Document in plan.md

### Data Loss
1. Stop all write operations
2. Restore from latest backup
3. Verify data integrity
4. Document incident
5. Update backup procedures

### Security Breach
1. Rotate all secrets immediately
2. Review access logs
3. Patch vulnerability
4. Notify affected users (if any)
5. Document and update security procedures

## Deployment Workflow

### Pre-Deployment Checklist
- [ ] All tests passing
- [ ] Coverage >80%
- [ ] No linting errors
- [ ] Mobile testing complete
- [ ] Environment variables configured
- [ ] Database migrations ready
- [ ] Backup created

### Deployment Steps
1. Merge feature branch to main
2. Tag release with version
3. Push to deployment service
4. Run database migrations
5. Verify deployment
6. Test critical paths
7. Monitor for errors

### Post-Deployment
1. Monitor analytics
2. Check error logs
3. Gather user feedback
4. Plan next iteration

## Continuous Improvement

- Review workflow weekly
- Update based on pain points
- Document lessons learned
- Optimize for user happiness
- Keep things simple and maintainable
