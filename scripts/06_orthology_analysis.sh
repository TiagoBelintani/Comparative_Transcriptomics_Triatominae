#!/bin/bash
# OrthoFinder and OrthoVenn
orthofinder -d -M msa -S diamond -z -t 20 -I 1.5 -f *.fa -n Orthofinder
# Upload to OrthoVenn3 web interface manually if needed
