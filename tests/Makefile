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

top_srcdir := $(shell cd .. ; pwd)

PYTHON3 ?= python3

all:

.PHONY: \
  check-doctest \
  check-mypy

.venv.done.log: \
  $(top_srcdir)/setup.cfg \
  $(top_srcdir)/setup.py
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
	  && cd $(top_srcdir) \
	    && pip install \
	      --editable \
	      .[testing]
	touch $@

# These check calls are provided in preferred run-order.
check: \
  check-mypy \
  check-doctest \
  check-pytest \
  check-relativity_to_venv \
  check-varying_top_srcdir

check-doctest: \
  .venv.done.log
	source venv/bin/activate \
	  && pytest \
	    --doctest-modules \
	    --log-level=DEBUG \
	    $(top_srcdir)/cdo_local_uuid

check-mypy: \
  .venv.done.log
	source venv/bin/activate \
	  && mypy \
	    --exclude varying_top_srcdir \
	    --exclude venv \
	    --strict \
	    $(top_srcdir)/cdo_local_uuid \
	    .

check-pytest: \
  .venv.done.log
	source venv/bin/activate \
	  && pytest \
	    --ignore relativity_to_venv \
	    --ignore varying_top_srcdir \
	    --log-level=DEBUG

check-relativity_to_venv: \
  .venv.done.log
	$(MAKE) \
	  PYTHON3=$(PYTHON3) \
	  --directory relativity_to_venv \
	  check

check-varying_top_srcdir: \
  .venv.done.log
	$(MAKE) \
	  --directory varying_top_srcdir \
	  check

clean:
	@rm -f \
	  .venv.done.log
	@rm -rf \
	  .pytest_cache \
	  venv
