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

# Purpose:
#
# This Makefile is intended to be loaded with the 'include' Make
# directive in one of the editability_*/Makefile files.  The variable
# installation_editable is expected to be 'yes' or 'no'.
# https://www.gnu.org/software/make/manual/html_node/Include.html
#
# This file is not intended to be used with Make by itself.
#
# This Makefile confirms that the same command line generates the same
# UUID sequence, and clarifies that redirection of stdout to a differing
# file path is not considered as part of the sequence seed.  It also
# recurses into dir_1/ to test different relative positions (pwd, or
# pwd's parent) for CDO_DEMO_NONRANDOM_UUID_BASE.

SHELL := /bin/bash

# NOTE: This top_srcdir is the "real" top source directory, the root
# directory of the cdo-local-uuid repository, for access to the
# cdo_local_uuid project as a local directory.
top_srcdir := $(shell cd ../../.. ; pwd)

PYTHON3 ?= python3

ifeq ($(installation_editable),)
$(error installation_editable undefined ; please define before the Make 'include' directive)
endif
ifeq ($(installation_editable),yes)
editable_flag=--editable
else
editable_flag=
endif

all: \
  all-dir_1 \
  output_0.txt \
  output_1.txt

%.txt: \
  .venv.done.log \
  cdo_example_command/__init__.py
	export CDO_DEMO_NONRANDOM_UUID_BASE="$$(pwd)" \
	  && source venv/bin/activate \
	    && cdo_example_command \
	      > _$@
	mv _$@ $@

.venv.done.log: \
  $(top_srcdir)/setup.cfg \
  $(top_srcdir)/setup.py \
  setup.cfg \
  setup.py
	rm -rf venv
	$(PYTHON3) -m venv \
	  venv
	source venv/bin/activate \
	  && pip install \
	    --upgrade \
	    pip \
	    setuptools \
	    wheel
	source venv/bin/activate \
	  && pip install \
	    $(top_srcdir)
	source venv/bin/activate \
	  && pip install \
	    $(editable_flag) \
	    .
	touch $@

all-dir_1: \
  .venv.done.log
	$(MAKE) \
	  --directory dir_1

check: \
  all

clean:
	@rm -f \
	  .venv.done.log \
	  *.txt
	@rm -rf \
	  venv
