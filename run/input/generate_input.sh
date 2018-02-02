#!/bin/bash
#####################################################################################
#  This script generates the INPUT_PHY and INPUT_ORG files for the Calibration      #
#  of the CCLM 5.0                                                                  #
#  Written 4/21/15 by Katie Osterried                                               #
#                                                                                   #
#  Updated 2/2/18 for the calibration with COSMO-POMPA                              #
#                                                                                   #
#####################################################################################

# Record the minimums and maximums of the parameters
rlam_heatn=0.1
rlam_heatx=2.0
v0snown=10.0
v0snowx=30.0
tkhminn=0.1
tkhminx=1.0
uc1n=0.0
uc1x=0.6
radfacn=0.3
radfacx=0.9
fac_rootdp2n=0.5
fac_rootdp2x=1.5
cgamman=0.1
cgammax=4.0
tur_lenn=20.0
tur_lenx=1000.0

# Now, set the abbreviations
rlam_heata='rl'
v0snowa='v'
tkhmina='tk'
uc1a='u'
radfaca='ra'
fac_rootdp2a='f'
cgammaa='c'
tur_lena='tu'

# Set some more variables
min='n'
max='x'

##################################################################################
# First, generate the one parameter variations
for param in rlam_heat v0snow tkhmin uc1 radfac fac_rootdp2 cgamma tur_len
do

  abbrev="$param"a
  loc=${!abbrev}loc

    # First the min
    cp INPUT_ORG/INPUT_ORG_reference INPUT_ORG/INPUT_ORG_${!abbrev}n
    val=$param$min
    sed -i "s/.*$param.*/    $param = ${!val},/" INPUT_ORG/INPUT_ORG_${!abbrev}n 

    cp INPUT_IO/INPUT_IO_reference INPUT_IO/INPUT_IO_${!abbrev}n
    sed -i "s/reference/${!abbrev}n/g" INPUT_IO/INPUT_IO_${!abbrev}n

    # Now the max
    cp INPUT_ORG/INPUT_ORG_reference INPUT_ORG/INPUT_ORG_${!abbrev}x
    val=$param$max
    sed -i "s/.*$param.*/    $param = ${!val},/" INPUT_ORG/INPUT_ORG_${!abbrev}x 

    cp INPUT_IO/INPUT_IO_reference INPUT_IO/INPUT_IO_${!abbrev}x
    sed -i "s/reference/${!abbrev}x/g" INPUT_IO/INPUT_IO_${!abbrev}x

done

###################################################################################
# Now, do the two parameter variations
i1='1'
for param1 in rlam_heat v0snow tkhmin uc1 radfac fac_rootdp2 cgamma tur_len
do
  i2='1'
  for param2 in rlam_heat v0snow tkhmin uc1 radfac fac_rootdp2 cgamma tur_len
  do
  
  if [ "$i1" -lt "$i2" ]
   then
   abbrev1="$param1"a
   abbrev2="$param2"a
 
   # First both parameters minimum
   val1=$param1$min
   val2=$param2$min

   cp INPUT_ORG/INPUT_ORG_reference INPUT_ORG/INPUT_ORG_${!abbrev1}n_${!abbrev2}n
   sed -i "s/.*$param1.*/    $param1 = ${!val1},/" INPUT_ORG/INPUT_ORG_${!abbrev1}n_${!abbrev2}n
   sed -i "s/.*$param2.*/    $param2 = ${!val2},/" INPUT_ORG/INPUT_ORG_${!abbrev1}n_${!abbrev2}n

   cp INPUT_IO/INPUT_IO_reference INPUT_IO/INPUT_IO_${!abbrev1}n_${!abbrev2}n
   sed -i "s/reference/${!abbrev1}n_${!abbrev2}n/g" INPUT_IO/INPUT_IO_${!abbrev1}n_${!abbrev2}n  

   # Next, param1 min and param2 max

   val1=$param1$min
   val2=$param2$max
   cp INPUT_ORG/INPUT_ORG_reference INPUT_ORG/INPUT_ORG_${!abbrev1}n_${!abbrev2}x
   sed -i "s/.*$param1.*/    $param1 = ${!val1},/" INPUT_ORG/INPUT_ORG_${!abbrev1}n_${!abbrev2}x
   sed -i "s/.*$param2.*/    $param2 = ${!val2},/" INPUT_ORG/INPUT_ORG_${!abbrev1}n_${!abbrev2}x

   cp INPUT_IO/INPUT_IO_reference INPUT_IO/INPUT_IO_${!abbrev1}n_${!abbrev2}x
   sed -i "s/reference/${!abbrev1}n_${!abbrev2}x/g" INPUT_IO/INPUT_IO_${!abbrev1}n_${!abbrev2}x

   # Param1 max and param2 min

   val1=$param1$max
   val2=$param2$min
   cp INPUT_ORG/INPUT_ORG_reference INPUT_ORG/INPUT_ORG_${!abbrev1}x_${!abbrev2}n
   sed -i "s/.*$param1.*/    $param1 = ${!val1},/" INPUT_ORG/INPUT_ORG_${!abbrev1}x_${!abbrev2}n
   sed -i "s/.*$param2.*/    $param2 = ${!val2},/" INPUT_ORG/INPUT_ORG_${!abbrev1}x_${!abbrev2}n

   cp INPUT_IO/INPUT_IO_reference INPUT_IO/INPUT_IO_${!abbrev1}x_${!abbrev2}n
   sed -i "s/reference/${!abbrev1}x_${!abbrev2}n/g" INPUT_IO/INPUT_IO_${!abbrev1}x_${!abbrev2}n

   # Both parameters max 
   cp INPUT_ORG/INPUT_ORG_reference INPUT_ORG/INPUT_ORG_${!abbrev1}x_${!abbrev2}x
   val1=$param1$max
   val2=$param2$max

   sed -i "s/.*$param1.*/    $param1 = ${!val1},/" INPUT_ORG/INPUT_ORG_${!abbrev1}x_${!abbrev2}x
   sed -i "s/.*$param2.*/    $param2 = ${!val2},/" INPUT_ORG/INPUT_ORG_${!abbrev1}x_${!abbrev2}x

   cp INPUT_IO/INPUT_IO_reference INPUT_IO/INPUT_IO_${!abbrev1}x_${!abbrev2}x
   sed -i "s/reference/${!abbrev1}x_${!abbrev2}x/g" INPUT_IO/INPUT_IO_${!abbrev1}x_${!abbrev2}x

  fi  

  i2=$(($i2+1))
  done
  i1=$(($i1+1))
done







