#!/bin/bash

#
# This script takes a directory path of samples as
# input and runs filtlong on them using light filtering 
# settings and outputs a filtered file as *_reads_filt.fastq.gz.
#

if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory path to samples>"
    exit 1
fi

dir="$1"
samples=$(find "$dir" -mindepth 1 -maxdepth 1 -type d)

for sample_path in $samples
do
  sample=$(basename "$sample_path")
  fastq_file=$(find "$sample_path" -name "$sample""*reads.fastq.gz")
	fastq_filt_file=$sample_path/"$sample"_reads_filt.fastq.gz
	
	echo 'Filtering: '"$(basename $fastq_file)"' ->' "$(basename $fastq_filt_file)"
	filtlong --min_length 1000 --keep_percent 95 "$fastq_file" > "$fastq_filt_file" 
done
