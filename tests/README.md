These tests confirm the impact, and mostly non-impact, of the following factors in usage of `cdo-local-uuid`:

* Whether a project's top source directory has an effect on the UUID seeding (e.g. via indepenent Git clones).
   - See `varying_top_srcdir/`.
* Whether the called program is installed in a virtual environment, or a standalone script.
   - See `relativity_to_venv/editability_*/cdo_example_command/__init__.py` for the former.
   - See `varying_top_srcdir/project_*/example.py` for the latter.
* Whether the virtual environment being in the same directory, or not, has an effect on the UUID seeding.
   - See `relativity_to_venv/editability_*/dir_1/Makefile` for call examples.
   
`pytest` scripts confirm when various factors are expected to influence and not influence the UUID seeding.
