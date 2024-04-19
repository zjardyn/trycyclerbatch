#!/bin/bash

#
# This script takes a directory path of sample
# as input and generates a consensus sequence from
# the clusters.
#

if [ $# -lt 1 ]; then
    echo "Usage: $0 <directory path to samples> <threads> "
    exit 1
fi

dir="$1"
threads="${2:-2}"
samples=$(find "$dir" -mindepth 1 -maxdepth 1 -type d)

for sample_path in $samples
do
    sample=$(basename "$sample_path")
    clusters=$(find "$sample_path" \
      -type d ! -path "$sample_path/trycycler/bad_clusters/cluster*" \
      -name "cluster_[0-9][0-9][0-9]"
    )
    for cluster in $clusters
    do
      trycycler consensus --cluster_dir "$cluster" --threads "$threads"
    done
done
