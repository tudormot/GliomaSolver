#!/bin/sh



echo "------------------------------------------------------"
echo "          SETTING-UP INFERENCE ENVIROMENT             "
echo "------------------------------------------------------"
ControlDir="../../control_scripts/"
cp -v ${ControlDir}brain* .

InputFile=Input.txt
DataPath=$(  cat ${InputFile} | awk -F '=' '/^DataPath/ {print $2}')
SolverPath=$(cat ${InputFile} | awk -F '=' '/^SolverPath/ {print $2}')
Nsamples=$(  cat ${InputFile} | awk -F '=' '/^Nsamples/ {print $2}')

echo ">>> Converting Input data nii2dat <<<"
echo "---------------------------------------"
MatlabTools="${SolverPath}tools/DataProcessing/source"
MyBase=$(pwd)
cd "${MatlabTools}"
bRotate=1
bResize=1
#matlab -nodisplay -nojvm -nosplash -nodesktop -r "nii2dat('${DataPath}',${bRotate},${bResize}); exit"
echo "debug, exited matlab script"
cd "$MyBase"

InputDataLocation=$(dirname "${DataPath}")
InputDataFolderName=$(basename "${DataPath}")
MRAGInputData="${MyBase}/glioma_data/"

# Folders name
PrepFolder=Preprocessing
TMP=Inference/TMPTMP/
LIKELIHOOD=Inference/Likelihood/makefile/


# Get Inference tools and scripts
cp -r "$SolverPath/tools/pi4u_lite/Inference" .
cp -r "$SolverPath/tools/scripts" . 

echo " "
echo "---------------------------------------"
echo ">>> Data Preprocessing <<<"
echo "---------------------------------------"
# Map data to MRAG grid
mkdir -p $PrepFolder
cp brain $PrepFolder
cp scripts/mapDataToMRAGrid.sh $PrepFolder
cp scripts/writeRunAll.sh $PrepFolder/
cp scripts/writeTMCMCpar.sh $PrepFolder/
cp scripts/GenericPrior.txt $PrepFolder/


cd $PrepFolder
./mapDataToMRAGrid.sh "$MRAGInputData" > PreprocessingReport.txt
echo " "
echo "---------------------------------------"
echo ">>> Setting up Patient-Specific Enviroment <<<"
echo "---------------------------------------"
./writeRunAll.sh "$MRAGInputData"
./writeTMCMCpar.sh $Nsamples

# Copy where they belong
cp brain ../$TMP
cp -v *dat ../$TMP
cp runAll.sh ../$TMP
cp tmcmc_glioma.par ../Inference/ 
cp ../${InputFile} ../Inference/

# Likelihood
cd ../${LIKELIHOOD}
make clean && make
cp likelihood ../../TMPTMP


echo " "
echo " "
echo "------------------------------------------------------"
echo "              DONE WITH THE SET-UP                    "
echo "------------------------------------------------------"
echo "To run the inference, please go to folder Inference/ and use run_inference.sh or run_inference_lrz.sh script (depending on your enviroment)."
echo "..........................................................."
echo "NOTE: Consider using tmux or cluster job handling system to run the inference."
echo "..........................................................."

echo "not actually done ! "
echo "updating run_inference.sh with correct TORC_WORKERS call"
cd ${MyBase}
cp -v ${ControlDir}run_inference.sh Inference/

echo "updating runAll.sh to use step=1"
cp -v ${ControlDir}runAll.sh Inference/TMPTMP/

echo "fixing extractInferenceOutput.sh:"
cp -v ${ControlDir}extractInferenceOutput.sh Inference/

echo "creating Inference_deeptumor file containing everything to run deeptumor inferene:"
cp -r Inference Inference_deeptumor
rm -r Inference_deeptumor/TMPTMP/*
cp -v ${ControlDir}runAll.sh_inotify Inference_deeptumor/TMPTMP/runAll.sh

