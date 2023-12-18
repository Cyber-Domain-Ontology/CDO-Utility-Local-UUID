#!/usr/bin/env python3

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

import logging
from pathlib import Path
from pprint import pformat
from typing import Set
from uuid import UUID


def _load_uuid(filename: str) -> UUID:
    with Path(filename).open("r") as fh:
        return UUID(fh.read().strip())


def test_expected_matches_seed_is_pwd() -> None:
    computed: Set[UUID] = set()
    for filename in [
        "editability_no/dir_1/output_base_here.txt",
        "editability_no/output_0.txt",
        "editability_no/output_1.txt",
        "editability_yes/dir_1/output_base_here.txt",
        "editability_yes/output_0.txt",
        "editability_yes/output_1.txt",
    ]:
        computed.add(_load_uuid(filename))
    try:
        assert (
            len(computed) == 1
        ), "Output where root directory was always process present working directory was affected by virtual environment being in different location from process present working directory, but shouldn't have been affected."
    except AssertionError:
        logging.debug(pformat(computed))
        raise


def test_expected_matches_seed_is_not_pwd() -> None:
    computed: Set[UUID] = set()
    for filename in [
        "editability_no/dir_1/output_base_above.txt",
        "editability_yes/dir_1/output_base_above.txt",
    ]:
        computed.add(_load_uuid(filename))
    try:
        assert (
            len(computed) == 1
        ), "Output where root directory was at different location from process pwd was affected by virtual environment being editable, but shouldn't have been affected."
    except AssertionError:
        logging.debug(pformat(computed))
        raise


def test_expected_mismatches() -> None:
    computed: Set[UUID] = set()
    for filename in [
        "editability_no/dir_1/output_base_above.txt",
        "editability_no/dir_1/output_base_here.txt",
    ]:
        computed.add(_load_uuid(filename))
    try:
        assert (
            len(computed) == 2
        ), "Output where root directory was at different relative locations matched, but shouldn't have."
    except AssertionError:
        logging.debug(pformat(computed))
        raise
