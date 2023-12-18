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

# Usage:
#
# This file is intended to be loaded into 'project_*/dir_*/Makefile'
# using the Make include directive.
# https://www.gnu.org/software/make/manual/html_node/Include.html
#
# A Make variable, output_txt, is expected to be defined before using
# the Make include directive.
#
# This file is not intended to be used with Make by itself.

SHELL := /bin/bash

# NOTE: This top_srcdir is the "real" top source directory, the root
# directory of the cdo-local-uuid repository, for access to the virtual
# environment.
top_srcdir := $(shell cd ../../../.. ; pwd)

output_txt ?=
ifeq ($(output_txt),)
$(error output_txt undefined ; please define before the Make 'include' directive)
endif

all: \
  $(output_txt)

%.txt: \
  $(top_srcdir)/cdo_local_uuid/__init__.py \
  $(top_srcdir)/tests/.venv.done.log \
  example.py
	export CDO_DEMO_NONRANDOM_UUID_BASE="$$(cd .. ; pwd)" \
	  && source $(top_srcdir)/tests/venv/bin/activate \
	    && python3 example.py > _$@
	mv _$@ $@

check: \
  all

clean:
	@rm -f \
	  *.txt
