#!/bin/sh
LIB_BASE="/home/tudorm/GliomaSolver/lib"
export PATH=${LIB_BASE}/mpich-install/bin:$PATH
export PATH=${LIB_BASE}/usr/torc/bin:$PATH

echo "Use mpicc:"
which mpicc

#Number of MPI ranks
M="$1"

START=$(date +%s.%N)
mpirun -np 1 -env TORC_WORKERS $M ./engine_tmcmc
END=$(date +%s.%N)
DIFF=$(echo "$END - $START")
echo "Start and end time (seconds):"
echo $DIFF

./extractInferenceOutput.sh
