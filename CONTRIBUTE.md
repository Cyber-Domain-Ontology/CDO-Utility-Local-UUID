# Contributing to CDO-Utility-Local-UUID

This project uses [the `pre-commit` tool](https://pre-commit.com/) for linting.  The easiest way to install it is with `pip`:
```bash
pip install pre-commit
pre-commit --version
```

The `pre-commit` tool hooks into Git's commit machinery to run a set of linters and static analyzers over each change. To install `pre-commit` into Git's hooks, run:
```bash
pre-commit install
```

To support offline development, `make` or `make check` will install and configure `pre-commit` in any local Git clone.
