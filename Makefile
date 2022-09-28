.PHONY: help
help:
	@echo Call one of the available targets:
	@sed -n 's/\(^[^.#[:space:]A-Z]*\):.*$$/\1/p' Makefile | uniq

.PHONY: test
test: test-critic test-tidy test-author

.PHONY: test-critic
test-critic:
	PERL5LIB=lib/perlcritic:$$PERL5LIB perlcritic lib

.PHONY: test-author
test-author:
	prove -l -r xt/
