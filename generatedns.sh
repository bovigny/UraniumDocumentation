for i in {53..80} ; do let j=$i+10; echo -e node-$i"    "IN"      "A"       "10.8.100.$j; done


for i in {53..80} ;  do let j=$i+10; echo -e $j"      "IN"      "PTR"     "node-$i.uranium.lan. ;done


for i in {53..80} ; do let j=$i+10; echo -e @"                               "IN"      "A"       "10.8.100.$j; done
for i in {53..80} ; do let j=$i+10; echo -e node-$i"                         "IN"      "A"       "10.8.100.$j; done
