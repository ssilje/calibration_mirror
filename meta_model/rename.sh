#!/bin/bash
rename_directory ()
{
run_dir='/hymet/ssilje/CALIBRATION_CA_emmanuele/data/long_calibration'
echo ${2}
echo ${1}
cd ${run_dir}   
if [ -d $run_dir/$1 ]
then
    echo "#######################"
    echo "                       "
    echo "Directory exist, check if the link exist ..."
    echo "                       "
    echo "#######################"
    if [ -L $run_dir/$2 ]
    then
	echo "#######################"
	echo "                       "
	echo "symbolic link exist, no work needed to be done ..."
	echo "                       "
	echo "#######################"
    else
	echo "#######################"
	echo "                       "
	echo "symbolic link does not exist, making symbolic link ..."
	echo "                       "
	echo "#######                "
	cd ${run_dir}              
	ln -sf ${1} ${2}
    fi
else
    echo "#######################"
    echo "                       "
    echo "Directory does not exist ..."
    echo "                       "
    echo "#######################"
fi
} #end function rename

interaction_rename ()
{
min='n'
max='x'
echo ${1} # param
echo ${2} # name1
nn1=${2}
pm=${1}

for interaction in rl v tk u ra d s e q 
	do
	    if [ ${interaction} == rl ]
	    then
		echo ${interaction}
		echo rlam_heat
		name2='rlam_heat'
		rename_directory ${nn1}_${name2}_11 ${pm}${min}_${interaction}${min} 
		rename_directory ${nn1}_${name2}_12 ${pm}${min}_${interaction}${max} 
		rename_directory ${nn1}_${name2}_22 ${pm}${max}_${interaction}${max} 
		rename_directory ${nn1}_${name2}_21 ${pm}${max}_${interaction}${min} 
	    fi
	    if [ ${interaction} == v ]
	    then
		echo ${interaction}
		echo v0snow
		name2='v0snow'
		rename_directory ${nn1}_${name2}_11 ${pm}${min}_${interaction}${min} 
		rename_directory ${nn1}_${name2}_12 ${pm}${min}_${interaction}${max} 
		rename_directory ${nn1}_${name2}_22 ${pm}${max}_${interaction}${max} 
		rename_directory ${nn1}_${name2}_21 ${pm}${max}_${interaction}${min} 
	    fi
	    if [ ${interaction} == tk ]
	    then
		echo ${interaction}
		echo tkhmin
		name2='tkhmin'
		rename_directory ${nn1}_${name2}_11 ${pm}${min}_${interaction}${min} 
		rename_directory ${nn1}_${name2}_12 ${pm}${min}_${interaction}${max} 
		rename_directory ${nn1}_${name2}_22 ${pm}${max}_${interaction}${max} 
		rename_directory ${nn1}_${name2}_21 ${pm}${max}_${interaction}${min} 
	    fi
	    if [ ${interaction} == u ]
	    then
		echo ${interaction}
		echo uc1
		name2='uc1'
		rename_directory ${nn1}_${name2}_11 ${pm}${min}_${interaction}${min} 
		rename_directory ${nn1}_${name2}_12 ${pm}${min}_${interaction}${max} 
		rename_directory ${nn1}_${name2}_22 ${pm}${max}_${interaction}${max} 
		rename_directory ${nn1}_${name2}_21 ${pm}${max}_${interaction}${min} 
	    fi
	    if [ ${interaction} == ra ]
	    then
		echo ${interaction}
		echo radfac
		name2='radfac'
		rename_directory ${nn1}_${name2}_11 ${pm}${min}_${interaction}${min} 
		rename_directory ${nn1}_${name2}_12 ${pm}${min}_${interaction}${max} 
		rename_directory ${nn1}_${name2}_22 ${pm}${max}_${interaction}${max} 
		rename_directory ${nn1}_${name2}_21 ${pm}${max}_${interaction}${min} 
	    fi

	    if [ ${interaction} == d ]
	    then
		echo ${interaction}
		echo d_mom
		name2='d_mom'
		rename_directory ${nn1}_${name2}_11 ${pm}${min}_${interaction}${min} 
		rename_directory ${nn1}_${name2}_12 ${pm}${min}_${interaction}${max} 
		rename_directory ${nn1}_${name2}_22 ${pm}${max}_${interaction}${max} 
		rename_directory ${nn1}_${name2}_21 ${pm}${max}_${interaction}${min} 
	    fi
	    if [ ${interaction} == s ]
	    then
		echo ${interaction}
		echo soilhyd
		name2='soilhyd'
		rename_directory ${nn1}_${name2}_11 ${pm}${min}_${interaction}${min} 
		rename_directory ${nn1}_${name2}_12 ${pm}${min}_${interaction}${max} 
		rename_directory ${nn1}_${name2}_22 ${pm}${max}_${interaction}${max} 
		rename_directory ${nn1}_${name2}_21 ${pm}${max}_${interaction}${min} 
	    fi

	    if [ ${interaction} == e ]
	    then
		echo ${interaction}
		echo e_surf
		name2='e_surf'
		rename_directory ${nn1}_${name2}_11 ${pm}${min}_${interaction}${min} 
		rename_directory ${nn1}_${name2}_12 ${pm}${min}_${interaction}${max} 
		rename_directory ${nn1}_${name2}_22 ${pm}${max}_${interaction}${max} 
		rename_directory ${nn1}_${name2}_21 ${pm}${max}_${interaction}${min} 
	    fi
	    if [ ${interaction} == q ]
	    then
		echo ${interaction}
		echo qi0
		name2='qi0'
		rename_directory ${nn1}_${name2}_11 ${pm}${min}_${interaction}${min} 
		rename_directory ${nn1}_${name2}_12 ${pm}${min}_${interaction}${max} 
		rename_directory ${nn1}_${name2}_22 ${pm}${max}_${interaction}${max} 
		rename_directory ${nn1}_${name2}_21 ${pm}${max}_${interaction}${min} 
	    fi	
done

}


cd ${run_dir}   
# First, run the reference 
echo "#######################"
echo "                       "
echo " Reference"
echo "                       "
echo "#######################"
rename_directory default reference 



# Next, the one parameter runs and interaction runs

min='n'
max='x'


for param in rl v tk u ra d s e q 
do
    if [ ${param} == rl ]
    then
	echo ${param}
	echo rlam_heat
	name1='rlam_heat'
	rename_directory ${name1}_1 ${param}${min} 
	rename_directory ${name1}_2 ${param}${max}
	
	interaction_rename ${param} ${name1}
    fi
	
    if [ ${param} == v ]
    then
	echo ${param}
	echo v0snow
	name1='v0snow'
	rename_directory ${name1}_1 ${param}${min} 
	rename_directory ${name1}_2 ${param}${max}
	
	interaction_rename ${param} ${name1}
	
    fi

    if [ ${param} == tk ]
    then
	echo ${param}
	echo tkhmin
	name1='tkhmin'
	rename_directory ${name1}_1 ${param}${min} 
	rename_directory ${name1}_2 ${param}${max}
	
	interaction_rename ${param} ${name1}
    fi

    if [ ${param} == u ]
    then
	echo ${param}
	echo uc1
	name1='uc1'
	rename_directory ${name1}_1 ${param}${min} 
	rename_directory ${name1}_2 ${param}${max}

	interaction_rename ${param} ${name1}
    fi

    if [ ${param} == ra ]
    then
	echo ${param}
	echo radfac
	name1='radfac'
	rename_directory ${name1}_1 ${param}${min} 
	rename_directory ${name1}_2 ${param}${max}

	interaction_rename ${param} ${name1}
    fi

    if [ ${param} == d ]
    then
	echo ${param}
	echo d_mom
	name1='d_mom'
	rename_directory ${name1}_1 ${param}${min} 
	rename_directory ${name1}_2 ${param}${max}

	interaction_rename ${param} ${name1}
    fi

    if [ ${param} == s ]
    then
	echo ${param}
	echo soilhyd
	name1='soilhyd'
	rename_directory ${name1}_1 ${param}${min} 
	rename_directory ${name1}_2 ${param}${max}

	interaction_rename ${param} ${name1}
    fi

    if [ ${param} == e ]
    then
	echo ${param}
	echo e_surf
	name1='e_surf'
	rename_directory ${name1}_1 ${param}${min} 
	rename_directory ${name1}_2 ${param}${max}

	interaction_rename ${param} ${name1}
    fi
    if [ ${param} == q ]
    then
	echo ${param}
	echo qi0
	name1='qi0'
	rename_directory ${name1}_1 ${param}${min} 
	rename_directory ${name1}_2 ${param}${max}
	interaction_rename ${param} ${name1}
    fi
done

