#!/bin/bash

# Enable exit on error and pipefail
set -e
set -o pipefail

dir=test/
threads=22
#!/bin/bash

# Start off clean
find "$dir" -mindepth 2 -maxdepth 2  -type f -o ! -wholename '*/barcode[0-9][0-9]' -exec rm -r {} \;
find "$dir" -mindepth 2 -maxdepth 2  -type d -o ! -wholename '*/barcode[0-9][0-9]' -exec rm -r {} \;

./1_cat_fastq.sh "$dir"
./2_fastqc.sh "$dir" "$threads"
./3_filtlong_lightqc.sh "$dir"
./4_trycycler_subsample.sh "$dir" "$threads" "5.5m"
./5_assemble.sh "$dir" "$threads"
./6_trycycler_cluster.sh "$dir" "$threads"
# ./8_trycycler_msa.sh "$dir" "$threads"
# ./9_trycycler_partition.sh "$dir" "$threads"
# ./10_trycycler_consensus.sh "$dir" "$threads"

