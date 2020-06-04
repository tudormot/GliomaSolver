InstallDir=$(pwd)
SolverDir=/home/tudorm/GliomaSolver
LIB_BASE=/home/tudorm/GliomaSolver/lib


echo " Installing torc:"
echo "--------------------------------------"
cd "${SolverDir}"/tools/pi4u_lite/torc_lite/
autoreconf
echo "between autoreconf and automake:"
automake --add-missing
./configure CC=mpicc --prefix="${LIB_BASE}"/usr/torc --with-maxnodes=1024
make
make install
export PATH="${LIB_BASE}"/usr/torc/bin:$PATH


echo " Compiling Inference tools:"
echo "--------------------------------------"
cd ../Inference
UserName=$(hostname -s)
cp tools.make/Makefile .
cp tools.make/setup_linux.sh setup_${UserName}.sh
cp tools.make/run_inference.sh .

sed -i 's|_USER_LIB_BASE_|'"${LIB_BASE}"'|g' Makefile
sed -i 's|_USER_LIB_BASE_|'"${LIB_BASE}"'|g' setup_${UserName}.sh
sed -i 's|_USER_LIB_BASE_|'"${LIB_BASE}"'|g' run_inference.sh

source setup_${UserName}.sh
make clean
make

echo " Installing pandoc:"
echo "--------------------------------------"
#sudo apt-get install pandoc pandoc-citeproc texlive


echo "  "
echo "==============================================="
echo ">>>     The Installation is completed       <<<"
echo "==============================================="
echo " "
echo "Please update your .bashrc or similar file to include path to the installed libraries."
echo " To do so, put the text between the following dashed lines into your .bashrc file:"
echo "---------------------------------------"
cat setup_${UserName}.sh
echo "---------------------------------------"
echo "To run the Inference use ./run_inference.sh or ./run_inference_LRZ.sh"
echo "For more info see the user manual"
echo "==============================================="

