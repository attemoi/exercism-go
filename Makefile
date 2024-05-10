# All directory names with trailing slash stripped
MODULES := $(patsubst %/,%,$(wildcard */))

.PHONY: all clean build $(MODULES)
.DEFAULT_GOAL := help

help:
	@echo "Usage: make <target>"
	@echo "Targets:"
	@echo "  clean     : Clean modules (usage: make clean [MODULE=<module_name>])"
	@echo "  fmt       : Format modules (usage: make fmt [MODULE=<module_name>])"
	@echo "  vet       : Vet modules (usage: make vet [MODULE=<module_name>])"
	@echo "  build     : Build modules (usage: make build [MODULE=<module_name>])"

fmt:
  $(call run_go, fmt)

vet:
	$(call run_go, vet)

build:
	$(call run_go, build)

test:
	$(call run_go, test)

clean:
		$(call run_go, clean)

define run_go
	@if [ -z "$(MODULE)" ]; then \
		for dir in $(MODULES); do \
			echo "Running $(1) $$dir"; \
			(cd $$dir && go $(1)) || exit $$?; \
		done; \
	else \
		if ! echo "$(MODULES)" | grep -qw "$(MODULE)"; then \
			echo "Error: Unknown module '$(MODULE)'"; \
			exit 1; \
		fi; \
		echo "$(1) $(MODULE)"; \
		(cd $(MODULE) && go $(1)) || exit $$?; \
	fi
endef

