#!/bin/bash
#SBATCH --account=ch4
#SBATCH --ntasks=96
#SBATCH --time=18:00:00
#SBATCH --output=log/CCLM5_calib_reference.out
#SBATCH --error=log/CCLM5_calib_reference.err
#SBATCH --job-name=calib_reference

/bin/rm /log/YU*

for f in /scratch/daint/ksilver/calibration/run/INPUT_*
do
ln -s $f .
done

ln -s /scratch/daint/ksilver/calibration/run/cclm .

# Run CLM in working directory
aprun -n 96 cclm

for f  in ./YU*
do
  mv $f log/$f.reference
done


