#!/bin/bash

#
# This script takes a directory path of samples as 
# input and concatenates the consensus fastas within each 
# cluster into a consensus fasta file. 
#
# This script assumes that remaining clusters have been reconciled,
# had an MSA performed, partitioned, and had a consensus generated.
#
# Bad clusters that did not pass these steps should be removed, or moved into
# another folder, such as /trycycler/badclusters.
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
    clusters=$(find "$sample_path"/trycycler/ -mindepth 1 -maxdepth 1 -name "cluster*")
    fasta=$(find "$sample_path"/trycycler/cluster* -mindepth 1 -maxdepth 1 -name "7*fasta")
    catfasta="$sample_path"/trycycler/consensus.fasta
    
    echo -n "Sample: $sample, Clusters: " 
    for i in $clusters; do
      echo -n $(basename $i)" " 
    done
    echo -n ", Outputting fasta to $sample/trycycler/consensus.fasta"
    echo ""
    # $fastq_files variable CANNOT be quoted for some reason
    cat $fasta > "$catfasta"
done
