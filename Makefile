UNAME_S := $(shell uname -s)
SWIFT_FLAGS ?= --disable-sandbox
PACKAGE_SWIFT_VERSION := $(shell grep "swift-tools-version" Package.swift | head -n 1 | cut -d ":" -f 2 | xargs)

# Repository name on GitHub Pages
REPO_NAME ?= math
# Subdirectory for versioned documentation (e.g., main, 1.0.0)
DOCS_VERSION_PATH ?= main

# The full base path for hosting
HOSTING_BASE_PATH ?= $(REPO_NAME)/$(DOCS_VERSION_PATH)

# Targets
.PHONY: setup lint lint-fix check-inlinable check-simd-coverage check-reference-coverage reference-values test-portable test test-coverage clean pre-commit docs docs-preview docs-generate docs-coverage profile-stats benchmark-commits benchmark benchmark-thresholds-check benchmark-thresholds-update

setup:
	@echo "Detected Package Swift Version: $(PACKAGE_SWIFT_VERSION)"
	@which mint > /dev/null || (echo "Mint not found. Installing via Homebrew..." && brew install mint)
	mint bootstrap
	swift package resolve $(SWIFT_FLAGS)

docs: docs-generate

docs-preview:
	swift package --disable-sandbox preview-documentation --target FirebladeMath

docs-generate:
	mkdir -p .build/documentation/$(DOCS_VERSION_PATH)
	swift package --disable-sandbox \
		--allow-writing-to-directory .build/documentation \
		generate-documentation --target FirebladeMath \
		--disable-indexing \
		--transform-for-static-hosting \
		--hosting-base-path $(HOSTING_BASE_PATH) \
		--output-path .build/documentation/$(DOCS_VERSION_PATH)
docs-coverage: docs-check-coverage

docs-check-coverage:
	swift package --disable-sandbox generate-documentation --target FirebladeMath --experimental-documentation-coverage --coverage-summary-level brief

docs-check-links:
	swift package --disable-sandbox generate-documentation --target FirebladeMath --analyze --warnings-as-errors

lint:
	mint run swiftlint lint --quiet
	mint run swiftformat --lint --swiftversion $(PACKAGE_SWIFT_VERSION) Sources/ Tests/

lint-fix:
	mint run swiftformat --swiftversion $(PACKAGE_SWIFT_VERSION) --config .swiftformat Sources/ Tests/
	mint run swiftlint --fix --config .swiftlint.yml Sources/ Tests/

check-inlinable:
	./Scripts/check-inlinable.sh

check-simd-coverage:
	python3 Scripts/check-simd-differential-coverage.py

check-reference-coverage:
	python3 Scripts/check-reference-coverage.py

# Regenerates the cross-platform reference values. Run on macOS with the default traits.
reference-values:
	FRB_MATH_REFERENCE_OUTPUT=$(CURDIR)/Tests/FirebladeMathTests/ReferenceValues/ReferenceData.swift \
		swift test $(SWIFT_FLAGS) -c release --filter ReferenceValueTests

# Portable implementations compared against Apple's simd (Apple platforms only).
test-portable:
	swift test $(SWIFT_FLAGS) --disable-default-traits --parallel -Xswiftc -warnings-as-errors

test:
	swift test $(SWIFT_FLAGS) --parallel --enable-code-coverage -Xswiftc -warnings-as-errors

test-coverage:
	$(MAKE) test
	@XCTEST_PATH=$$(find .build -name "*.xctest" | grep "FirebladeMath" | head -n 1); \
	if [ -z "$$XCTEST_PATH" ]; then \
		echo "Could not find .xctest bundle"; \
		exit 1; \
	fi; \
	if [ "$(UNAME_S)" = "Darwin" ]; then \
		BINARY_PATH=$$(find "$$XCTEST_PATH" -type f -perm +111 | grep -v "CodeResources" | head -n 1); \
	else \
		BINARY_PATH="$$XCTEST_PATH/FirebladeMathPackageTests"; \
	fi; \
	xcrun llvm-cov report \
		"$$BINARY_PATH" \
		-instr-profile=.build/debug/codecov/default.profdata \
		-ignore-filename-regex=".build|Tests"

pre-commit: lint-fix test

clean:
	swift package clean
	rm -rf .build
	rm -rf .swiftpm

profile-stats:
	chmod +x Scripts/profile-compiler-stats.sh
	./Scripts/profile-compiler-stats.sh

benchmark-commits:
	chmod +x Scripts/profile-compiler-stats.sh
	chmod +x Scripts/benchmark-commits.py
	python3 Scripts/benchmark-commits.py

benchmark:
	cd Benchmarks && swift package benchmark

benchmark-thresholds-check:
	cd Benchmarks && swift package benchmark thresholds check --metric mallocCountTotal

benchmark-thresholds-update:
	cd Benchmarks && swift package --allow-writing-to-package-directory benchmark thresholds update --metric mallocCountTotal
