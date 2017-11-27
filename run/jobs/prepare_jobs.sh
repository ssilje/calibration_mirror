#!/bin/bash

#######################################################################################
#  This script (prepare_jobs.sh) creates all of the slurm submission scripts for the  #
#  129 runs needed for the calibration of the CCLM 5.0.  It also copies the INPUT_PHY,#
#  INPUT_ORG, and INPUT_IO files and creates the (empty) log and output folders.      #
#  Written 4/22/15 by Katie Osterried                                                 #
#######################################################################################

# List of the abbreviations for the parameters:
#rlam_heat='rl'
#entr_sc='e'
#qi0='q'
#uc1='u'
#fac_rootdp2='f'
#tkhmin='t'
#radfac='ra'
#soilhyd='s'



##########################################################################
#                          Reference run                                 #
##########################################################################

# Make the folder in the run directory
mkdir /scratch/daint/ksilver/calibration/run/reference
# Copy the reference run script
cp job_reference.sh /scratch/daint/ksilver/calibration/run/reference/job_run.sh
# Copy the INPUT_PHY file
cp ../input/INPUT_PHY/INPUT_PHY_reference /scratch/daint/ksilver/calibration/run/reference/INPUT_PHY
# Copy the INPUT_ORG file
cp ../input/INPUT_ORG/INPUT_ORG_reference /scratch/daint/ksilver/calibration/run/reference/INPUT_ORG
# Copy the INPUT_IO file
cp ../input/INPUT_IO/INPUT_IO_reference /scratch/daint/ksilver/calibration/run/reference/INPUT_IO
# Make the output and log files
mkdir /scratch/daint/ksilver/calibration/run/reference/output
mkdir /scratch/daint/ksilver/calibration/run/reference/output/out01
mkdir /scratch/daint/ksilver/calibration/run/reference/output/out02
mkdir /scratch/daint/ksilver/calibration/run/reference/log


# Set some variables
min='n'
max='x'

##########################################################################
#                            One parameter runs                          #
##########################################################################
for param in rl e q u f t ra s
do
#####################
# First the minimum #
#####################

# Make the folders in the run directory
mkdir /scratch/daint/ksilver/calibration/run/$param$min
# Copy the reference run script
cp job_reference.sh /scratch/daint/ksilver/calibration/run/$param$min/job_run.sh
# Replace the phrase reference with the name of the run
sed -i "s/reference/$param$min/g" /scratch/daint/ksilver/calibration/run/$param$min/job_run.sh
# Copy the INPUT_PHY file
cp ../input/INPUT_PHY/INPUT_PHY_$param$min /scratch/daint/ksilver/calibration/run/$param$min/INPUT_PHY
# Copy the INPUT_ORG file
cp ../input/INPUT_ORG/INPUT_ORG_$param$min /scratch/daint/ksilver/calibration/run/$param$min/INPUT_ORG
# Copy the INPUT_IO file
cp ../input/INPUT_IO/INPUT_IO_$param$min /scratch/daint/ksilver/calibration/run/$param$min/INPUT_IO
# Make the output and log files
mkdir /scratch/daint/ksilver/calibration/run/$param$min/output 
mkdir /scratch/daint/ksilver/calibration/run/$param$min/output/out01
mkdir /scratch/daint/ksilver/calibration/run/$param$min/output/out02
mkdir /scratch/daint/ksilver/calibration/run/$param$min/log

###################
# Now the maximum #
###################

# Make the folders in the run directory
mkdir /scratch/daint/ksilver/calibration/run/$param$max
# Copy the reference run script
cp job_reference.sh /scratch/daint/ksilver/calibration/run/$param$max/job_run.sh
# Replace the phrase reference with the name of the run
sed -i "s/reference/$param$max/g" /scratch/daint/ksilver/calibration/run/$param$max/job_run.sh
# Copy the INPUT_PHY file
cp ../input/INPUT_PHY/INPUT_PHY_$param$max /scratch/daint/ksilver/calibration/run/$param$max/INPUT_PHY
# Copy the INPUT_ORG file
cp ../input/INPUT_ORG/INPUT_ORG_$param$max /scratch/daint/ksilver/calibration/run/$param$max/INPUT_ORG
# Copy the INPUT_IO file
cp ../input/INPUT_IO/INPUT_IO_$param$max /scratch/daint/ksilver/calibration/run/$param$max/INPUT_IO
# Make the output and log folders
mkdir /scratch/daint/ksilver/calibration/run/$param$max/output
mkdir /scratch/daint/ksilver/calibration/run/$param$max/output/out01
mkdir /scratch/daint/ksilver/calibration/run/$param$max/output/out02
mkdir /scratch/daint/ksilver/calibration/run/$param$max/log

done

#############################################################################
#                            2 parameter runs                               #
#############################################################################
i1='1'
for param1 in rl e q u f t ra s
  do
  i2='1'
  for param2 in rl e q u f t ra s
    do
    if [ "$i1" -lt "$i2" ]
      then
    ###########################
    # Both parameters minimum #
    ###########################
    
    val1=$param1$min
    val2=$param2$min

    # Make the folder in the run directory
      mkdir /scratch/daint/ksilver/calibration/run/${val1}_${val2}
    # Copy the run script
      cp job_reference.sh /scratch/daint/ksilver/calibration/run/${val1}_${val2}/job_run.sh
    # Replace the phrase "reference" with the name of the run
      sed -i "s/reference/${val1}_${val2}/g" /scratch/daint/ksilver/calibration/run/${val1}_${val2}/job_run.sh
    # Copy the INPUT_PHY file
      cp ../input/INPUT_PHY/INPUT_PHY_${val1}_${val2} /scratch/daint/ksilver/calibration/run/${val1}_${val2}/INPUT_PHY
    # Copy the INPUT_ORG file
      cp ../input/INPUT_ORG/INPUT_ORG_${val1}_${val2} /scratch/daint/ksilver/calibration/run/${val1}_${val2}/INPUT_ORG
    # Copy the INPUT_IO file
      cp ../input/INPUT_IO/INPUT_IO_${val1}_${val2} /scratch/daint/ksilver/calibration/run/${val1}_${val2}/INPUT_IO
    # Make the output and log folders
      mkdir /scratch/daint/ksilver/calibration/run/${val1}_${val2}/output
      mkdir /scratch/daint/ksilver/calibration/run/${val1}_${val2}/output/out01
      mkdir /scratch/daint/ksilver/calibration/run/${val1}_${val2}/output/out02
      mkdir /scratch/daint/ksilver/calibration/run/${val1}_${val2}/log

    #############################
    # param1 min and param2 max #
    #############################

    val1=$param1$min
    val2=$param2$max

    # Make the folder in the run directory
      mkdir /scratch/daint/ksilver/calibration/run/${val1}_${val2}
    # Copy the run script
      cp job_reference.sh /scratch/daint/ksilver/calibration/run/${val1}_${val2}/job_run.sh
    # Replace the phrase "reference" with the name of the run
      sed -i "s/reference/${val1}_${val2}/g" /scratch/daint/ksilver/calibration/run/${val1}_${val2}/job_run.sh
    # Copy the INPUT_PHY file
      cp ../input/INPUT_PHY/INPUT_PHY_${val1}_${val2} /scratch/daint/ksilver/calibration/run/${val1}_${val2}/INPUT_PHY
    # Copy the INPUT_ORG file
      cp ../input/INPUT_ORG/INPUT_ORG_${val1}_${val2} /scratch/daint/ksilver/calibration/run/${val1}_${val2}/INPUT_ORG
    # Copy the INPUT_IO file
      cp ../input/INPUT_IO/INPUT_IO_${val1}_${val2} /scratch/daint/ksilver/calibration/run/${val1}_${val2}/INPUT_IO
    # Make the output and log folders
      mkdir /scratch/daint/ksilver/calibration/run/${val1}_${val2}/output
      mkdir /scratch/daint/ksilver/calibration/run/${val1}_${val2}/output/out01
      mkdir /scratch/daint/ksilver/calibration/run/${val1}_${val2}/output/out02
      mkdir /scratch/daint/ksilver/calibration/run/${val1}_${val2}/log

    #############################
    # param1 max and param2 min #
    #############################

    val1=$param1$max
    val2=$param2$min

    # Make the folder in the run directory
      mkdir /scratch/daint/ksilver/calibration/run/${val1}_${val2}
    # Copy the run script
      cp job_reference.sh /scratch/daint/ksilver/calibration/run/${val1}_${val2}/job_run.sh
    # Replace the phrase "reference" with the name of the run
      sed -i "s/reference/${val1}_${val2}/g" /scratch/daint/ksilver/calibration/run/${val1}_${val2}/job_run.sh
    # Copy the INPUT_PHY file
      cp ../input/INPUT_PHY/INPUT_PHY_${val1}_${val2} /scratch/daint/ksilver/calibration/run/${val1}_${val2}/INPUT_PHY
    # Copy the INPUT_ORG file
      cp ../input/INPUT_ORG/INPUT_ORG_${val1}_${val2} /scratch/daint/ksilver/calibration/run/${val1}_${val2}/INPUT_ORG
    # Copy the INPUT_IO file
      cp ../input/INPUT_IO/INPUT_IO_${val1}_${val2} /scratch/daint/ksilver/calibration/run/${val1}_${val2}/INPUT_IO

    # Make the output and log folders
      mkdir /scratch/daint/ksilver/calibration/run/${val1}_${val2}/output
      mkdir /scratch/daint/ksilver/calibration/run/${val1}_${val2}/output/out01
      mkdir /scratch/daint/ksilver/calibration/run/${val1}_${val2}/output/out02
      mkdir /scratch/daint/ksilver/calibration/run/${val1}_${val2}/log
    
    ############################
    # Both parameters maximum  #
    ############################

    val1=$param1$max
    val2=$param2$max

    # Make the folder in the run directory
      mkdir /scratch/daint/ksilver/calibration/run/${val1}_${val2}
    # Copy the run script
      cp job_reference.sh /scratch/daint/ksilver/calibration/run/${val1}_${val2}/job_run.sh
    # Replace the phrase "reference" with the name of the run
      sed -i "s/reference/${val1}_${val2}/g" /scratch/daint/ksilver/calibration/run/${val1}_${val2}/job_run.sh
    # Copy the INPUT_PHY file
      cp ../input/INPUT_PHY/INPUT_PHY_${val1}_${val2} /scratch/daint/ksilver/calibration/run/${val1}_${val2}/INPUT_PHY
    # Copy the INPUT_ORG file
      cp ../input/INPUT_ORG/INPUT_ORG_${val1}_${val2} /scratch/daint/ksilver/calibration/run/${val1}_${val2}/INPUT_ORG
    # Copy the INPUT_IO file
      cp ../input/INPUT_IO/INPUT_IO_${val1}_${val2} /scratch/daint/ksilver/calibration/run/${val1}_${val2}/INPUT_IO

    # Make the output and log folders
      mkdir /scratch/daint/ksilver/calibration/run/${val1}_${val2}/output
      mkdir /scratch/daint/ksilver/calibration/run/${val1}_${val2}/output/out01
      mkdir /scratch/daint/ksilver/calibration/run/${val1}_${val2}/output/out02
      mkdir /scratch/daint/ksilver/calibration/run/${val1}_${val2}/log

    fi
  
    i2=$(($i2+1))
    done
    i1=$(($i1+1))
  done

