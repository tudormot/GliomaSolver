#0) Enviroment
#------------------
N=1
export OMP_NUM_THREADS=$N

# 1) Glioma growth
#------------------
program=brain
model=RD
verbose=0
adaptive=1
vtk=0
UQ=1
dumpfreq=20
PatFileName="/home/tudorm/GliomaSolver/20P_corr/rec001_pre/glioma_data//"

./$program -nthreads $N -model $model -verbose $verbose -adaptive $adaptive -PatFileName $PatFileName -vtk $vtk -dumpfreq $dumpfreq -UQ $UQ

# Likelihood
#------------------
stepPET=1
stepMRI=1
bROI=1

./likelihood -stepPET $stepPET -stepMRI $stepMRI -bROI $bROI
