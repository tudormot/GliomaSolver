#!/bin/sh
LIB_BASE="/home/tudorm/GliomaSolver/lib"
export PATH=${LIB_BASE}/mpich-install/bin:$PATH
export PATH=${LIB_BASE}/usr/torc/bin:$PATH

echo "Use mpicc:"
which mpicc

#Number of MPI ranks
M="$1"

mpirun -np $M ./engine_tmcmc

./extractInferenceOutput.sh
