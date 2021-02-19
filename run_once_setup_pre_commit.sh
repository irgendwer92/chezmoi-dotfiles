#!/bin/sh
set -ex

cd $(chezmoi source-path)
pre-commit install
