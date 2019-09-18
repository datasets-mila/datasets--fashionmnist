#!/bin/bash
set -o errexit -o pipefail

# this script is meant to be used with 'datalad run'

for file_url in \
        "http://fashion-mnist.s3-website.eu-central-1.amazonaws.com/train-images-idx3-ubyte.gz train-images-idx3-ubyte.gz" \
        "http://fashion-mnist.s3-website.eu-central-1.amazonaws.com/train-labels-idx1-ubyte.gz train-labels-idx1-ubyte.gz" \
        "http://fashion-mnist.s3-website.eu-central-1.amazonaws.com/t10k-images-idx3-ubyte.gz t10k-images-idx3-ubyte.gz" \
        "http://fashion-mnist.s3-website.eu-central-1.amazonaws.com/t10k-labels-idx1-ubyte.gz t10k-labels-idx1-ubyte.gz"
do
        echo ${file_url} | git-annex addurl -c annex.largefiles=anything --raw --batch --with-files
done

md5sum -c md5sums
