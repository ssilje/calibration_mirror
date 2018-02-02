#!/bin/bash
#####################################################################################
#  This script extracts the monthly mean 2m temperature, precipitation, cloud cover,#
#  and daily temperature range for the period 1994-1998.  The data is taken from    #
#  the E-obs and CRU datasets and also averaged over the PRUDENCE regions.          #
#  Written 4/9/15 by Katie Osterried                                                #
#####################################################################################

# Do the time subset and the monthly mean all in one command

# Start with 2m mean temperature
cdo monmean -seldate,1994-01-01,1998-12-30 /project/ch4/observations/eobs_0.44deg_rot_v10.0/tg_0.44deg_rot_v10.0.nc \t2m_mm.nc

# Now precipitation

cdo monmean -seldate,1994-01-01,1998-12-30 /project/ch4/observations/eobs_0.44deg_rot_v10.0/rr_0.44deg_rot_v10.0.nc \rr_mm.nc

# Now DTR (= Max temp(tx) - Min temp(tn))

cdo monmean -sub -seldate,1994-01-01,1998-12-30 /project/ch4/observations/eobs_0.44deg_rot_v10.0/tx_0.44deg_rot_v10.0.nc -seldate,1994-01-01,1998-12-30 /project/ch4/observations/eobs_0.44deg_rot_v10.0/tn_0.44deg_rot_v10.0.nc dtr_mm.nc

# Now the CRU (cloud cover data)

# Get the observational grid from the EOBS data
cdo griddes /project/ch4/observations/eobs_0.44deg_rot_v10.0/tx_0.44deg_rot_v10.0.nc > grid_model.txt

# Select the date range, map to the EOBS data grid, and take the monthly mean of the CRU data

cdo monmean -remapbil,grid_model.txt -seldate,1994-01-01,1998-12-30 /project/ch4/observations/clct/cru_ts3.22.1901.2013.cld.dat.nc clct_mm.nc

# Remove the grid file

rm grid_model.txt

# Now do the averaging over the PRUDENCE regions
# 2m Temperature
cdo fldmean -sellonlatbox,-10,2,50,59 t2m_mm.nc t2m_1.nc
cdo fldmean -sellonlatbox,-10,3,36,44 t2m_mm.nc t2m_2.nc
cdo fldmean -sellonlatbox,-5,5,44,50 t2m_mm.nc t2m_3.nc
cdo fldmean -sellonlatbox,2,16,48,55 t2m_mm.nc t2m_4.nc
cdo fldmean -sellonlatbox,5,30,55,70 t2m_mm.nc t2m_5.nc
cdo fldmean -sellonlatbox,5,15,44,48 t2m_mm.nc t2m_6.nc
cdo fldmean -sellonlatbox,3,25,36,44 t2m_mm.nc t2m_7.nc
cdo fldmean -sellonlatbox,16,30,44,55 t2m_mm.nc t2m_8.nc

#Precipitation
cdo fldmean -sellonlatbox,-10,2,50,59 rr_mm.nc rr_1.nc
cdo fldmean -sellonlatbox,-10,3,36,44 rr_mm.nc rr_2.nc
cdo fldmean -sellonlatbox,-5,5,44,50 rr_mm.nc rr_3.nc
cdo fldmean -sellonlatbox,2,16,48,55 rr_mm.nc rr_4.nc
cdo fldmean -sellonlatbox,5,30,55,70 rr_mm.nc rr_5.nc
cdo fldmean -sellonlatbox,5,15,44,48 rr_mm.nc rr_6.nc
cdo fldmean -sellonlatbox,3,25,36,44 rr_mm.nc rr_7.nc
cdo fldmean -sellonlatbox,16,30,44,55 rr_mm.nc rr_8.nc

# DTR
cdo fldmean -sellonlatbox,-10,2,50,59 dtr_mm.nc dtr_1.nc
cdo fldmean -sellonlatbox,-10,3,36,44 dtr_mm.nc dtr_2.nc
cdo fldmean -sellonlatbox,-5,5,44,50 dtr_mm.nc dtr_3.nc
cdo fldmean -sellonlatbox,2,16,48,55 dtr_mm.nc dtr_4.nc
cdo fldmean -sellonlatbox,5,30,55,70 dtr_mm.nc dtr_5.nc
cdo fldmean -sellonlatbox,5,15,44,48 dtr_mm.nc dtr_6.nc
cdo fldmean -sellonlatbox,3,25,36,44 dtr_mm.nc dtr_7.nc
cdo fldmean -sellonlatbox,16,30,44,55 dtr_mm.nc dtr_8.nc

# Cloud cover
cdo fldmean -sellonlatbox,-10,2,50,59 clct_mm.nc clct_1.nc
cdo fldmean -sellonlatbox,-10,3,36,44 clct_mm.nc clct_2.nc
cdo fldmean -sellonlatbox,-5,5,44,50 clct_mm.nc clct_3.nc
cdo fldmean -sellonlatbox,2,16,48,55 clct_mm.nc clct_4.nc
cdo fldmean -sellonlatbox,5,30,55,70 clct_mm.nc clct_5.nc
cdo fldmean -sellonlatbox,5,15,44,48 clct_mm.nc clct_6.nc
cdo fldmean -sellonlatbox,3,25,36,44 clct_mm.nc clct_7.nc
cdo fldmean -sellonlatbox,16,30,44,55 clct_mm.nc clct_8.nc
