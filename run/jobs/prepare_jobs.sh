#!/bin/bash

#######################################################################################
#  This script (prepare_jobs.sh) creates all of the slurm submission scripts for the  #
#  129 runs needed for the calibration of the CCLM 5.0.  It also copies the INPUT_PHY,#
#  INPUT_ORG, and INPUT_IO files and creates the (empty) log and output folders.      #
#  Written 4/22/15 by Katie Osterried                                                 #
#######################################################################################

run_dir='/scratch/snx3000/ksilver/calibration/run'

##########################################################################
#                          Reference run                                 #
##########################################################################

# Make the folder in the run directory
mkdir $run_dir/reference
# Copy the reference run script
cp job_reference.sh $run_dir/reference/job_run.sh
# Copy the INPUT_ORG file
cp ../input/INPUT_ORG/INPUT_ORG_reference $run_dir/reference/INPUT_ORG
# Copy the INPUT_IO file
cp ../input/INPUT_IO/INPUT_IO_reference $run_dir/reference/INPUT_IO
# Make the output and log files
mkdir $run_dir/reference/output
mkdir $run_dir/reference/output/out01
mkdir $run_dir/reference/output/out02
mkdir $run_dir/reference/log

# Set some variables
min='n'
max='x'

##########################################################################
#                            One parameter runs                          #
##########################################################################
for param in rl v tk u ra f c tu
do
#####################
# First the minimum #
#####################

# Make the folders in the run directory
mkdir $run_dir/$param$min
# Copy the reference run script
cp job_reference.sh $run_dir/$param$min/job_run.sh
# Replace the phrase reference with the name of the run
sed -i "s/reference/$param$min/g" $run_dir/$param$min/job_run.sh
# Copy the INPUT_ORG file
cp ../input/INPUT_ORG/INPUT_ORG_$param$min $run_dir/$param$min/INPUT_ORG
# Copy the INPUT_IO file
cp ../input/INPUT_IO/INPUT_IO_$param$min $run_dir/$param$min/INPUT_IO
# Make the output and log files
mkdir $run_dir/$param$min/output 
mkdir $run_dir/$param$min/output/out01
mkdir $run_dir/$param$min/output/out02
mkdir $run_dir/$param$min/log

###################
# Now the maximum #
###################

# Make the folders in the run directory
mkdir $run_dir/$param$max
# Copy the reference run script
cp job_reference.sh $run_dir/$param$max/job_run.sh
# Replace the phrase reference with the name of the run
sed -i "s/reference/$param$max/g" $run_dir/$param$max/job_run.sh
# Copy the INPUT_ORG file
cp ../input/INPUT_ORG/INPUT_ORG_$param$max $run_dir/$param$max/INPUT_ORG
# Copy the INPUT_IO file
cp ../input/INPUT_IO/INPUT_IO_$param$max $run_dir/$param$max/INPUT_IO
# Make the output and log folders
mkdir $run_dir/$param$max/output
mkdir $run_dir/$param$max/output/out01
mkdir $run_dir/$param$max/output/out02
mkdir $run_dir/$param$max/log

done

#############################################################################
#                            2 parameter runs                               #
#############################################################################
i1='1'
for param1 in rl v tk u ra f c tu
  do
  i2='1'
  for param2 in rl v tk u ra f c tu
    do
    if [ "$i1" -lt "$i2" ]
      then
    ###########################
    # Both parameters minimum #
    ###########################
    
    val1=$param1$min
    val2=$param2$min

    # Make the folder in the run directory
      mkdir $run_dir/${val1}_${val2}
    # Copy the run script
      cp job_reference.sh $run_dir/${val1}_${val2}/job_run.sh
    # Replace the phrase "reference" with the name of the run
      sed -i "s/reference/${val1}_${val2}/g" $run_dir/${val1}_${val2}/job_run.sh
    # Copy the INPUT_ORG file
      cp ../input/INPUT_ORG/INPUT_ORG_${val1}_${val2} $run_dir/${val1}_${val2}/INPUT_ORG
    # Copy the INPUT_IO file
      cp ../input/INPUT_IO/INPUT_IO_${val1}_${val2} $run_dir/${val1}_${val2}/INPUT_IO
    # Make the output and log folders
      mkdir $run_dir/${val1}_${val2}/output
      mkdir $run_dir/${val1}_${val2}/output/out01
      mkdir $run_dir/${val1}_${val2}/output/out02
      mkdir $run_dir/${val1}_${val2}/log

    #############################
    # param1 min and param2 max #
    #############################

    val1=$param1$min
    val2=$param2$max

    # Make the folder in the run directory
      mkdir $run_dir/${val1}_${val2}
    # Copy the run script
      cp job_reference.sh $run_dir/${val1}_${val2}/job_run.sh
    # Replace the phrase "reference" with the name of the run
      sed -i "s/reference/${val1}_${val2}/g" $run_dir/${val1}_${val2}/job_run.sh
    # Copy the INPUT_ORG file
      cp ../input/INPUT_ORG/INPUT_ORG_${val1}_${val2} $run_dir/${val1}_${val2}/INPUT_ORG
    # Copy the INPUT_IO file
      cp ../input/INPUT_IO/INPUT_IO_${val1}_${val2} $run_dir/${val1}_${val2}/INPUT_IO
    # Make the output and log folders
      mkdir $run_dir/${val1}_${val2}/output
      mkdir $run_dir/${val1}_${val2}/output/out01
      mkdir $run_dir/${val1}_${val2}/output/out02
      mkdir $run_dir/${val1}_${val2}/log

    #############################
    # param1 max and param2 min #
    #############################

    val1=$param1$max
    val2=$param2$min

    # Make the folder in the run directory
      mkdir $run_dir/${val1}_${val2}
    # Copy the run script
      cp job_reference.sh $run_dir/${val1}_${val2}/job_run.sh
    # Replace the phrase "reference" with the name of the run
      sed -i "s/reference/${val1}_${val2}/g" $run_dir/${val1}_${val2}/job_run.sh
    # Copy the INPUT_ORG file
      cp ../input/INPUT_ORG/INPUT_ORG_${val1}_${val2} $run_dir/${val1}_${val2}/INPUT_ORG
    # Copy the INPUT_IO file
      cp ../input/INPUT_IO/INPUT_IO_${val1}_${val2} $run_dir/${val1}_${val2}/INPUT_IO

    # Make the output and log folders
      mkdir $run_dir/${val1}_${val2}/output
      mkdir $run_dir/${val1}_${val2}/output/out01
      mkdir $run_dir/${val1}_${val2}/output/out02
      mkdir $run_dir/${val1}_${val2}/log
    
    ############################
    # Both parameters maximum  #
    ############################

    val1=$param1$max
    val2=$param2$max

    # Make the folder in the run directory
      mkdir $run_dir/${val1}_${val2}
    # Copy the run script
      cp job_reference.sh $run_dir/${val1}_${val2}/job_run.sh
    # Replace the phrase "reference" with the name of the run
      sed -i "s/reference/${val1}_${val2}/g" $run_dir/${val1}_${val2}/job_run.sh
    # Copy the INPUT_ORG file
      cp ../input/INPUT_ORG/INPUT_ORG_${val1}_${val2} $run_dir/${val1}_${val2}/INPUT_ORG
    # Copy the INPUT_IO file
      cp ../input/INPUT_IO/INPUT_IO_${val1}_${val2} $run_dir/${val1}_${val2}/INPUT_IO

    # Make the output and log folders
      mkdir $run_dir/${val1}_${val2}/output
      mkdir $run_dir/${val1}_${val2}/output/out01
      mkdir $run_dir/${val1}_${val2}/output/out02
      mkdir $run_dir/${val1}_${val2}/log

    fi
  
    i2=$(($i2+1))
    done
    i1=$(($i1+1))
  done

