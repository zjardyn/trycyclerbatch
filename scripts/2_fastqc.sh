#!/bin/bash

#
# This script takes a directory path of samples as 
# input and runs fastqc on the concatenated fastq 
# file within each sample directory.
#

if [ $# -lt 2 ]; then
    echo "Usage: $0 <directory path to samples>, <threads>"
    exit 1
fi

dir="$1"
threads="$2"

samples=$(find "$dir" -mindepth 1 -maxdepth 1 -type d)
for sample_path in $samples
do
	sample=$(basename "$sample_path")
  fastq_file=$(find "$sample_path" -name "$sample""*reads.fastq.gz")
	qc_path=$sample_path/fastqc/
	# quoted this post-analysis, if it doesn't run in the future..
	mkdir -p "$qc_path"
	qc_files="$qc_path"$(basename "$fastq_file")
	
	echo "Running fastqc on sample: $sample using $(basename "$fastq_file")"
	fastqc "$fastq_file" -o "$qc_path" -t "$threads" 
done
