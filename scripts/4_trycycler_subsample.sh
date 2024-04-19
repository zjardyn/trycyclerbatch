#!/bin/bash

#
# This script takes a directory path of samples
# as input and runs trycyler subsample on the 
# filtered fastq reads to generate subsets 
# for assembly.
#

if [ $# -lt 2 ]; then
    echo "Usage: $0 <directory path to samples> <threads> <optional: genome_size>"
    exit 1
fi

dir="$1"
threads="$2"
genome_size="${3:-}"

samples=$(find "$dir" -mindepth 1 -maxdepth 1 -type d)

for sample_path in $samples
do
  sample=$(basename "$sample_path")
  fastq_file=$(find "$sample_path" -name "$sample""*_filt.fastq.gz")
	out_dir="$sample_path"/read_subsets

  if [ -z "$3" ]; then
    echo 'Subsampling: '"$(basename "$fastq_file")"
    trycycler subsample --reads "$fastq_file" --out_dir "$out_dir" --threads "$threads"
  else
    echo 'Subsampling: '"$(basename "$fastq_file")"
    trycycler subsample --reads "$fastq_file" --out_dir "$out_dir" --threads "$threads" --genome_size "$genome_size"
  fi
done
