#!/bin/bash

conda create -n gilbert-phylo muscle mafft t-coffee dialign-tx prank iqtree clustalo clustalw
conda create -n gilbert-prep blast prokka
