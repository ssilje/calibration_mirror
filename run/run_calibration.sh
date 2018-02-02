#!/bin/bash

##############################################################################
# This script (run_calibration.sh) submits all of the Slurm scripts for the  #
# 129 calibration runs.                                                      #
# Written 4/27/15 by Katie Osterried                                         #
##############################################################################


# First, run the reference 

cd /scratch/daint/ksilver/calibration/run/reference

pwd
sbatch job_run.sh

# Next, the one parameter runs

min='n'
max='x'

for param in rl e q u f t ra s
do

# First the minimum

cd /scratch/daint/ksilver/calibration/run/$param$min
pwd
sbatch job_run.sh

# Then the maximum

cd /scratch/daint/ksilver/calibration/run/$param$max
pwd
sbatch job_run.sh

done

# Finally, the two parameter runs
i1='1'
for param1 in rl e q u f t ra s
  do
  i2='1'
  for param2 in rl e q u f t ra s
    do
    if [ "$i1" -lt "$i2" ]
      then
      # Both parameters minimum
      val1=$param1$min
      val2=$param2$min

      cd /scratch/daint/ksilver/calibration/run/${val1}_${val2}
      pwd
      sbatch job_run.sh      

      # param1 min and param2 max
      val1=$param1$min
      val2=$param2$max

      cd /scratch/daint/ksilver/calibration/run/${val1}_${val2}
      pwd
      sbatch job_run.sh

      # param1 max and param2 min
      val1=$param1$max
      val2=$param2$min

      cd /scratch/daint/ksilver/calibration/run/${val1}_${val2}
      pwd 
      sbatch job_run.sh

      # Both parameters maximum
      val1=$param1$max
      val2=$param2$max

      cd /scratch/daint/ksilver/calibration/run/${val1}_${val2}
      pwd
      sbatch job_run.sh

    fi

    i2=$(($i2+1))
  done
    i1=$(($i1+1))
done
