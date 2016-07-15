#!/bin/bash

for i in `seq 0 9`; do
	rm "cmc-$i.test" "cmc-$i.data"
	rm "cmc-$i.data.model" "cmc-$i.predic" "cmc-$i.data.nonscaled" "cmc-$i.test.nonscaled"
	rm "cmc-$i.original.test" "cmc-$i.original.data"
	rm "cmc-$i.original.predic" "cmc-$i.original.prediction" "cmc-$i.original.tree"
	rm "cmc-$i.original.nb" "cmc-$i.original.unpruned" "cmc-$i.original.names"
	rm x$i
done
rm "cmc.original.data" "scaling_parameters"
