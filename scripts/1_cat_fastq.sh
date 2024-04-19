#!/bin/bash

#
# This script takes a directory path of samples as 
# input and concatenates the fastq reads within each 
# sample into a named fastq file.
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
    fastq_files=$(find "$sample_path" -name "*.fastq.gz")
    catfastq="$sample_path/$sample"_reads.fastq.gz

    echo "Concatenating fastq files from sample: $sample"
    # $fastq_files variable CANNOT be quoted for cat to work on it. 
    cat $fastq_files > "$catfastq"
done
