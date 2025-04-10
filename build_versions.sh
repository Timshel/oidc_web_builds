# !/bin/bash

set -e

# Contain only the tag when it point to the commit
TAG_CURRENT=$(git describe --tags HEAD)
