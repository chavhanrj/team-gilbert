#!/bin/bash

#Filter csv file to get genbank ftp links
cat Mycoplasma_genomes.csv | awk -F ',' '{print $15}' | tail -n +2 | sed 's/ftp:/rsync:/g' > links.txt

#call rsync to download genomes
while read p; do rsync --copy-links --recursive --times --verbose $p; done < links.txt

#retrieve gbff files and unzip them
mv */*.gbff.gz ./
gunzip *.gbff.gz
