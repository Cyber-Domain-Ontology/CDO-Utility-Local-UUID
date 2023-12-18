#!/usr/bin/make -f

# Portions of this file contributed by NIST are governed by the
# following statement:
#
# This software was developed at the National Institute of Standards
# and Technology by employees of the Federal Government in the course
# of their official duties. Pursuant to Title 17 Section 105 of the
# United States Code, this software is not subject to copyright
# protection within the United States. NIST assumes no responsibility
# whatsoever for its use by other parties, and makes no guarantees,
# expressed or implied, about its quality, reliability, or any other
# characteristic.
#
# We would appreciate acknowledgement if the software is used.

SHELL := /bin/bash

top_srcdir := $(shell cd ../.. ; pwd)

PYTHON3 ?= python3

all: \
  all-editability_no \
  all-editability_yes

all-editability_no:
	$(MAKE) \
	  --directory editability_no

all-editability_yes:
	$(MAKE) \
	  --directory editability_yes

check: \
  all

check: \
  all
	source $(top_srcdir)/tests/venv/bin/activate \
	  && pytest \
	    --log-level=DEBUG \
	    --verbose \
	    test_outputs.py

clean: \
  clean-editability_no \
  clean-editability_yes

clean-editability_no:
	@$(MAKE) \
	  --directory editability_no \
	  clean

clean-editability_yes:
	@$(MAKE) \
	  --directory editability_yes \
	  clean
