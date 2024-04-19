#!/bin/bash

#
# This script runs flye, miniasm/minipolish, and
# raven assemblers on the subsetted reads, per
# sample.
#

if [ $# -lt 2 ]; then
    echo "Usage: $0 <directory path to samples> <threads>"
    exit 1
fi

dir="$1"
threads="$2"  # change as appropriate for your system

dirs=$(ls $dir)
for i in $dirs
do
  dir_s=$dir$i/read_subsets/
	dir_a=$dir$i/assemblies/
	dir_i=$dir$i/
	mkdir $dir_a

	flye --nano-hq "$dir_s"sample_01.fastq --threads "$threads" --out-dir "$dir_i"assembly_01 && cp "$dir_i"assembly_01/assembly.fasta "$dir_a"assembly_01.fasta && cp "$dir_i"assembly_01/assembly_graph.gfa "$dir_a"assembly_01.gfa && rm -r "$dir_i"assembly_01
	miniasm_and_minipolish.sh "$dir_s"sample_02.fastq "$threads" > "$dir_a"assembly_02.gfa && any2fasta "$dir_a"assembly_02.gfa > "$dir_a"assembly_02.fasta
	raven --threads "$threads" --disable-checkpoints --graphical-fragment-assembly "$dir_a"assembly_03.gfa "$dir_s"sample_03.fastq > "$dir_a"assembly_03.fasta

	flye --nano-hq "$dir_s"sample_04.fastq --threads "$threads" --out-dir "$dir_i"assembly_04 && cp "$dir_i"assembly_04/assembly.fasta "$dir_a"assembly_04.fasta && cp "$dir_i"assembly_04/assembly_graph.gfa "$dir_a"assembly_04.gfa && rm -r "$dir_i"assembly_04
	miniasm_and_minipolish.sh "$dir_s"sample_05.fastq "$threads" > "$dir_a"assembly_05.gfa && any2fasta "$dir_a"assembly_05.gfa > "$dir_a"assembly_05.fasta
	raven --threads "$threads" --disable-checkpoints --graphical-fragment-assembly "$dir_a"assembly_06.gfa "$dir_s"sample_06.fastq > "$dir_a"assembly_06.fasta

	flye --nano-hq "$dir_s"sample_07.fastq --threads "$threads" --out-dir "$dir_i"assembly_07 && cp "$dir_i"assembly_07/assembly.fasta "$dir_a"assembly_07.fasta && cp "$dir_i"assembly_07/assembly_graph.gfa "$dir_a"assembly_07.gfa && rm -r "$dir_i"assembly_07
	miniasm_and_minipolish.sh "$dir_s"sample_08.fastq "$threads" > "$dir_a"assembly_08.gfa && any2fasta "$dir_a"assembly_08.gfa > "$dir_a"assembly_08.fasta
	raven --threads "$threads" --disable-checkpoints --graphical-fragment-assembly "$dir_a"assembly_09.gfa "$dir_s"sample_09.fastq > "$dir_a"assembly_09.fasta

	flye --nano-hq "$dir_s"sample_10.fastq --threads "$threads" --out-dir "$dir_i"assembly_10 && cp "$dir_i"assembly_10/assembly.fasta "$dir_a"assembly_10.fasta && cp "$dir_i"assembly_10/assembly_graph.gfa "$dir_a"assembly_10.gfa && rm -r "$dir_i"assembly_10
	miniasm_and_minipolish.sh "$dir_s"sample_11.fastq "$threads" > "$dir_a"assembly_11.gfa && any2fasta "$dir_a"assembly_11.gfa > "$dir_a"assembly_11.fasta
	raven --threads "$threads" --disable-checkpoints --graphical-fragment-assembly "$dir_a"assembly_12.gfa "$dir_s"sample_12.fastq > "$dir_a"assembly_12.fasta
done
