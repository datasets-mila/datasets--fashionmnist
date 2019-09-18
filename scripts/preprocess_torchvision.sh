#!/bin/bash
set -o errexit -o pipefail

# this script is meant to be used with 'datalad run'

_SNAME=$(basename "$0")

source scripts/utils.sh echo -n

mkdir -p logs/

python3 -m pip install -r scripts/requirements_torchvision.txt

# Move data files to FashionMNIST/raw as it is where torchvision looks for
# FashionMNIST raw files
mkdir -p FashionMNIST/raw
git mv t10k-*.gz FashionMNIST/raw
git mv train-*.gz FashionMNIST/raw
git-annex fsck FashionMNIST/raw

python3 scripts/preprocess_torchvision.py \
	1>>logs/${_SNAME}.out_$$ 2>>logs/${_SNAME}.err_$$

# Delete raw files
git rm -rf FashionMNIST/raw/*.gz md5sums

git-annex add -c annex.largefiles=anything FashionMNIST
