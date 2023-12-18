# Varying the top source directory

This directory confirms that when a project source tree is copied to multiple directories (e.g. via independent Git clones), the source tree's top directory as a changing value of `CDO_DEMO_NONRANDOM_UUID_BASE` does not influence programs in the top directory, nor below the top directory.  The Python test in this directory confirms generated UUIDs match only when they're expected to, and mismatch in expected cases.
