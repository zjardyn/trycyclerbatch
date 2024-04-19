#!/bin/bash

#
# This script takes a directory path of samples
# as input and runs medaka on the consensus reads 
# within the clusters to generate polished reads.
#

if [ $# -lt 2 ]; then
    echo "Usage: $0 <directory path to samples> <threads>"
    exit 1
fi

dir="$1"
threads="$2"
samples=$(find "$dir" -mindepth 1 -maxdepth 1 -type d)

for sample_path in $samples
do
  trycycler_path="$sample_path"/trycycler/
  # reads=$(find "$sample_path" -name "4_reads.fastq")
  # consensus=$(find "$sample_path" -name "7_final_consensus.fasta")
  cluster_path=$(find "$sample_path" -name "cluster_*")
  
  for c in $cluster_path; do
      medaka_consensus -i "$c"/4_reads.fastq -d "$c"/7_final_consensus.fasta -o "$c"/medaka -m r1041_e82_400bps_fast_g615 -t "$threads" 
      mv "$c"/medaka/consensus.fasta "$c"/8_medaka.fasta
      rm -r "$c"/medaka "$c"/*.fai "$c"/*.mmi  # clean up
  done
done


# for c in trycycler/cluster_*; do
#     medaka_consensus -i "$c"/4_reads.fastq -d "$c"/7_final_consensus.fasta -o "$c"/medaka -m r1041_e82_400bps_fast_g615 -t 12
#     mv "$c"/medaka/consensus.fasta "$c"/8_medaka.fasta
#     rm -r "$c"/medaka "$c"/*.fai "$c"/*.mmi  # clean up
# done
