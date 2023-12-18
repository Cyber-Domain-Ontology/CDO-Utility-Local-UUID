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

all: \
  all-project_1 \
  all-project_2

all-project_1: \
  $(top_srcdir)/tests/.venv.done.log
	$(MAKE) \
	  --directory project_1

all-project_2: \
  $(top_srcdir)/tests/.venv.done.log
	$(MAKE) \
	  --directory project_2

check: \
  all
	source $(top_srcdir)/tests/venv/bin/activate \
	  && pytest \
	    --log-level=DEBUG \
	    --verbose \
	    test_outputs.py

clean: \
  clean-project_1 \
  clean-project_2

clean-project_1:
	@$(MAKE) \
	  --directory project_1 \
	  clean

clean-project_2:
	@$(MAKE) \
	  --directory project_2 \
	  clean
