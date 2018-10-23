# Arguments
# $1 first timepoint
# $2 last timepoint
# $3 number of CPU
echo "RUNNING PROCESS STACK"
echo $1
echo $2
echo $3
seq -w $1 $2 | parallel -j $3 ProcessStack /usr/src/app/TGMM/data/test_config.txt {}
echo "RUNNING TGMM"
TGMM /usr/src/app/TGMM/data/test_config.txt $1 $2

