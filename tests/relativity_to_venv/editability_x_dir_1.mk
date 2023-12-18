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
# directive in one of the editability_*/dir_1/Makefile files.

SHELL := /bin/bash

all: \
  output_base_above.txt \
  output_base_here.txt

check: \
  all

clean:
	@rm -f \
	  *.txt

output_base_above.txt: \
  ../.venv.done.log \
  ../cdo_example_command/__init__.py
	export CDO_DEMO_NONRANDOM_UUID_BASE="$$(cd .. ; pwd)" \
	  && source ../venv/bin/activate \
	    && cdo_example_command \
	      > _$@
	mv _$@ $@

output_base_here.txt: \
  ../.venv.done.log \
  ../cdo_example_command/__init__.py
	export CDO_DEMO_NONRANDOM_UUID_BASE="$$(pwd)" \
	  && source ../venv/bin/activate \
	    && cdo_example_command \
	      > _$@
	mv _$@ $@
