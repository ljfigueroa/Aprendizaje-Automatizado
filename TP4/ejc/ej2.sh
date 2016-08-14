#!/bin/bash
cd A    && sh sc.sh
cd ../B && sh sc.sh
cd ../
Rscript graficar.r
cd A    && sh clean.sh
cd ../B && sh clean.sh
#
