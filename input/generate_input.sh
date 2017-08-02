#!/bin/bash
#####################################################################################
#  This script generates the INPUT_PHY and INPUT_ORG files for the Calibration      #
#  of the CCLM 5.0                                                                  #
#  Written 4/21/15 by Katie Osterried                                               #
#####################################################################################

# Record the minimums and maximums of the parameters
rlam_heatn=0.1
rlam_heatx=5.0
entr_scn=0.00003
entr_scx=0.003
qi0n=0.00005
qi0x=0.0001
uc1n=0.0
uc1x=1.6
fac_rootdp2n=0.5
fac_rootdp2x=1.5
tkhminn=0.1
tkhminx=2.0
radfacn=0.3
radfacx=0.9
soilhydn=0.1
soilhydx=10.0

# Now, set the abbreviations
rlam_heata='rl'
entr_sca='e'
qi0a='q'
uc1a='u'
fac_rootdp2a='f'
tkhmina='t'
radfaca='ra'
soilhyda='s'

# Set some more variables
min='n'
max='x'

# Set the location of the parameter
rlloc='ORG'
eloc='ORG'
qloc='ORG'
uloc='PHY'
floc='PHY'
tloc='ORG'
raloc='PHY'
sloc='PHY'

##################################################################################
# First, generate the one parameter variations
for param in rlam_heat entr_sc qi0 uc1 fac_rootdp2 tkhmin radfac soilhyd
do

  abbrev="$param"a
  loc=${!abbrev}loc

    # First the min
    cp INPUT_PHY/INPUT_PHY_reference INPUT_PHY/INPUT_PHY_${!abbrev}n
    cp INPUT_ORG/INPUT_ORG_reference INPUT_ORG/INPUT_ORG_${!abbrev}n
    val=$param$min
    sed -i "s/.*$param.*/    $param = ${!val},/" INPUT_${!loc}/INPUT_${!loc}_${!abbrev}n 

    cp INPUT_IO/INPUT_IO_reference INPUT_IO/INPUT_IO_${!abbrev}n
    sed -i "s/reference/${!abbrev}n/g" INPUT_IO/INPUT_IO_${!abbrev}n

    # Now the max
    cp INPUT_PHY/INPUT_PHY_reference INPUT_PHY/INPUT_PHY_${!abbrev}x
    cp INPUT_ORG/INPUT_ORG_reference INPUT_ORG/INPUT_ORG_${!abbrev}x
    val=$param$max
    sed -i "s/.*$param.*/    $param = ${!val},/" INPUT_${!loc}/INPUT_${!loc}_${!abbrev}x 

    cp INPUT_IO/INPUT_IO_reference INPUT_IO/INPUT_IO_${!abbrev}x
    sed -i "s/reference/${!abbrev}x/g" INPUT_IO/INPUT_IO_${!abbrev}x

done

###################################################################################
# Now, do the two parameter variations
i1='1'
for param1 in rlam_heat entr_sc qi0 uc1 fac_rootdp2 tkhmin radfac soilhyd
do
  i2='1'
  for param2 in rlam_heat entr_sc qi0 uc1 fac_rootdp2 tkhmin radfac soilhyd
  do
  
  if [ "$i1" -lt "$i2" ]
   then
   abbrev1="$param1"a
   abbrev2="$param2"a
   loc1=${!abbrev1}loc
   loc2=${!abbrev2}loc
 
   # First both parameters minimum
   val1=$param1$min
   val2=$param2$min

   cp INPUT_ORG/INPUT_ORG_reference INPUT_ORG/INPUT_ORG_${!abbrev1}n_${!abbrev2}n
   cp INPUT_PHY/INPUT_PHY_reference INPUT_PHY/INPUT_PHY_${!abbrev1}n_${!abbrev2}n
   sed -i "s/.*$param1.*/    $param1 = ${!val1},/" INPUT_${!loc1}/INPUT_${!loc1}_${!abbrev1}n_${!abbrev2}n
   sed -i "s/.*$param2.*/    $param2 = ${!val2},/" INPUT_${!loc2}/INPUT_${!loc2}_${!abbrev1}n_${!abbrev2}n

   cp INPUT_IO/INPUT_IO_reference INPUT_IO/INPUT_IO_${!abbrev1}n_${!abbrev2}n
   sed -i "s/reference/${!abbrev1}n_${!abbrev2}n/g" INPUT_IO/INPUT_IO_${!abbrev1}n_${!abbrev2}n  

   # Next, param1 min and param2 max

   val1=$param1$min
   val2=$param2$max
   cp INPUT_ORG/INPUT_ORG_reference INPUT_ORG/INPUT_ORG_${!abbrev1}n_${!abbrev2}x
   cp INPUT_PHY/INPUT_PHY_reference INPUT_PHY/INPUT_PHY_${!abbrev1}n_${!abbrev2}x
   sed -i "s/.*$param1.*/    $param1 = ${!val1},/" INPUT_${!loc1}/INPUT_${!loc1}_${!abbrev1}n_${!abbrev2}x
   sed -i "s/.*$param2.*/    $param2 = ${!val2},/" INPUT_${!loc2}/INPUT_${!loc2}_${!abbrev1}n_${!abbrev2}x

   cp INPUT_IO/INPUT_IO_reference INPUT_IO/INPUT_IO_${!abbrev1}n_${!abbrev2}x
   sed -i "s/reference/${!abbrev1}n_${!abbrev2}x/g" INPUT_IO/INPUT_IO_${!abbrev1}n_${!abbrev2}x

   # Param1 max and param2 min

   val1=$param1$max
   val2=$param2$min
   cp INPUT_ORG/INPUT_ORG_reference INPUT_ORG/INPUT_ORG_${!abbrev1}x_${!abbrev2}n
   cp INPUT_PHY/INPUT_PHY_reference INPUT_PHY/INPUT_PHY_${!abbrev1}x_${!abbrev2}n
   sed -i "s/.*$param1.*/    $param1 = ${!val1},/" INPUT_${!loc1}/INPUT_${!loc1}_${!abbrev1}x_${!abbrev2}n
   sed -i "s/.*$param2.*/    $param2 = ${!val2},/" INPUT_${!loc2}/INPUT_${!loc2}_${!abbrev1}x_${!abbrev2}n

   cp INPUT_IO/INPUT_IO_reference INPUT_IO/INPUT_IO_${!abbrev1}x_${!abbrev2}n
   sed -i "s/reference/${!abbrev1}x_${!abbrev2}n/g" INPUT_IO/INPUT_IO_${!abbrev1}x_${!abbrev2}n

   # Both parameters max 
   cp INPUT_ORG/INPUT_ORG_reference INPUT_ORG/INPUT_ORG_${!abbrev1}x_${!abbrev2}x
   cp INPUT_PHY/INPUT_PHY_reference INPUT_PHY/INPUT_PHY_${!abbrev1}x_${!abbrev2}x
   val1=$param1$max
   val2=$param2$max

   sed -i "s/.*$param1.*/    $param1 = ${!val1},/" INPUT_${!loc1}/INPUT_${!loc1}_${!abbrev1}x_${!abbrev2}x
   sed -i "s/.*$param2.*/    $param2 = ${!val2},/" INPUT_${!loc2}/INPUT_${!loc2}_${!abbrev1}x_${!abbrev2}x

   cp INPUT_IO/INPUT_IO_reference INPUT_IO/INPUT_IO_${!abbrev1}x_${!abbrev2}x
   sed -i "s/reference/${!abbrev1}x_${!abbrev2}x/g" INPUT_IO/INPUT_IO_${!abbrev1}x_${!abbrev2}x

  fi  

  i2=$(($i2+1))
  done
  i1=$(($i1+1))
done







