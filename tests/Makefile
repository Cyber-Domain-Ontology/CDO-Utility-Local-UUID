#!/usr/bin/make -f

# Portions of this file contributed by NIST are governed by the following
# statement:
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
  check-doctest
	source venv/bin/activate \
	  && pytest \
	    --log-level=DEBUG

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
	    --exclude venv \
	    --strict \
	    $(top_srcdir)/cdo_local_uuid \
	    .

clean:
	@rm -f \
	  .venv.done.log
	@rm -rf \
	  .pytest_cache \
	  venv
