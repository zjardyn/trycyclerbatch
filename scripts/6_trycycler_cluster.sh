#!/bin/bash

#
# This script takes a directory path of samples
# as input and runs trycyler cluster on the assemblies
# to generate clusters for visualization.
#

if [ $# -lt 2 ]; then
    echo "Usage: $0 <directory path to samples> <threads>"
    exit 1
fi

dir="$1"
threads="$2"

dirs=$(ls $dir)
for i in $dirs
do
	dir_a=$dir$i/assemblies/
	dir_i=$dir$i/
	trycycler cluster \
		--assemblies "$dir_a"*.fasta \
		--reads "$dir_i"*_filt.fastq.gz \
		--out_dir "$dir_i"trycycler \
		--threads "$threads"
done
