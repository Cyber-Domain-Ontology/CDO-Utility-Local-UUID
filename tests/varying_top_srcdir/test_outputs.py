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

from pathlib import Path
from uuid import UUID

p1: UUID
p1d1: UUID
p1d2: UUID
p2: UUID
p2d1: UUID
p2d2: UUID

srcdir = Path(__file__).parent

with (srcdir / "project_1" / "output_0.txt").open("r") as fh:
    p1 = UUID(fh.read().strip())

with (srcdir / "project_2" / "output_0.txt").open("r") as fh:
    p2 = UUID(fh.read().strip())

with (srcdir / "project_1" / "dir_1" / "output_1.txt").open("r") as fh:
    p1d1 = UUID(fh.read().strip())

with (srcdir / "project_1" / "dir_2" / "output_2.txt").open("r") as fh:
    p1d2 = UUID(fh.read().strip())

with (srcdir / "project_2" / "dir_1" / "output_1.txt").open("r") as fh:
    p2d1 = UUID(fh.read().strip())

with (srcdir / "project_2" / "dir_2" / "output_2.txt").open("r") as fh:
    p2d2 = UUID(fh.read().strip())


def test_p1_p2() -> None:
    assert (
        p1 == p2
    ), "Output in root directory varies between project copies, but shouldn't."


def test_p1_p1d1() -> None:
    assert p1 != p1d1, "Output in root directory matched subdirectory, but shouldn't."


def test_p1d1_p2d1() -> None:
    assert p1d1 == p2d1, "Output in d1 varies between project copies, but shouldn't."


def test_p1d2_p2d2() -> None:
    assert p1d2 == p2d2, "Output in d2 varies between project copies, but shouldn't."


def test_p1d1_p1d2() -> None:
    assert p1d1 != p1d2, "Output in d1 matches d2, but shouldn't."
