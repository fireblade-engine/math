UNAME_S := $(shell uname -s)
SWIFT_FLAGS ?= --disable-sandbox
PACKAGE_SWIFT_VERSION := $(shell grep "swift-tools-version" Package.swift | head -n 1 | cut -d ":" -f 2 | xargs)

# Targets
.PHONY: setup lint lint-fix test test-coverage clean pre-commit docs docs-coverage

setup:
	@echo "Detected Package Swift Version: $(PACKAGE_SWIFT_VERSION)"
	@which mint > /dev/null || (echo "Mint not found. Installing via Homebrew..." && brew install mint)
	mint bootstrap
	swift package resolve $(SWIFT_FLAGS)

docs:
	swift package generate-documentation --target FirebladeMath

docs-coverage:
	swift package generate-documentation --target FirebladeMath --experimental-documentation-coverage --coverage-summary-level detailed

lint:
	mint run swiftlint lint --quiet
	mint run swiftformat --lint --swiftversion $(PACKAGE_SWIFT_VERSION) Sources/ Tests/

lint-fix:
	mint run swiftformat --swiftversion $(PACKAGE_SWIFT_VERSION) --config .swiftformat Sources/ Tests/
	mint run swiftlint --fix --config .swiftlint.yml Sources/ Tests/

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
