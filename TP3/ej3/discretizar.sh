#!/bin/bash

input="dos_elipses-0.01-0.5-5,450000.predic"
output="RedNeuronal-discretizado.predic"

awk '{$3 = ($3 <= 0.5 ? 0 : 1)} 1' $input > $output
