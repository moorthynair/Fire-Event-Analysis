# -*- coding: utf-8 -*-
"""
Created on Sat Apr  9 10:21:04 2022

@author: USER
"""

import pandas as pd
import numpy as np
import rasterio as rio
from rasterio.plot import show
import geopandas as gpd
from datetime import datetime as dt
import matplotlib.pyplot as plt
from datetime import date


##Read the instructions
#1. Downlaod all the fire related informations from 3 platforms from NASA-FIRMS
#2. Collate all the data in a folder names 'fires' and save it in download section
# or else provide relevant path below to read the data

## Input all the fire informations
fire1 = gpd.read_file('C:/Users/USER/Downloads/fires/J1_VIIRS_C2_South_Asia_7d.shp')
fire2 = gpd.read_file('C:/Users/USER/Downloads/fires/MODIS_C6_1_South_Asia_7d.shp')
fire3 = gpd.read_file('C:/Users/USER/Downloads/fires/SUOMI_VIIRS_C2_South_Asia_7d.shp')

## Append all the fire details
fire = fire1.append(fire2).append(fire3)
fire['ACQ_DATE'] = fire['ACQ_DATE'].apply(lambda x: dt.strptime(x,'%Y-%m-%d').strftime('%Y-%m-%d'))

##Input block wise shapefile
block = gpd.read_file('F:/neeri/MODIS/PF AND PANCHYAT BOUNDARY/PANCHAYAT_BOUND_WITH_FOREST_ATTRIBUTES.shp')

##Forest boundary file
forest = gpd.read_file('F:/neeri/MODIS/PF AND PANCHYAT BOUNDARY/PF_BOUNDARY_2019.shp')
forest.to_crs('EPSG:4326', inplace=True)

## Retreive forest fires
forest_fire = gpd.overlay(fire,forest, how='intersection')
#forest_fire.to_file('forest_fire.shp')

##drop the duplicates from the retrieved forest fire data
j = forest_fire[['LATITUDE','LONGITUDE']]
duplicates = pd.Series(j.duplicated()).value_counts()

if duplicates[1]>0:
    p = pd.Series(j.duplicated()).to_numpy().tolist()
    indexes = np.where(p)[0]
    forest_fire.drop(index=indexes, inplace=True)
    forest_fire.reset_index(inplace=True)

forest_fire = forest_fire.iloc[:, np.r_[1,2,6,7,9,11:13,17:20,22:25]]

##Retrive non-forest fires
non_forest_fires = gpd.overlay(fire, forest, how='difference')
non_forest_fires_bihar = gpd.overlay(non_forest_fires,block,how='intersection')

#Check for duplicates
j = non_forest_fires_bihar[['LATITUDE','LONGITUDE']]
duplicates = pd.Series(j.duplicated()).value_counts()

if duplicates[1]>0:
    p = pd.Series(j.duplicated()).to_numpy().tolist()
    indexes = np.where(p)[0]
    non_forest_fires_bihar.drop(index=indexes, inplace=True)
    non_forest_fires_bihar.reset_index(inplace=True)

non_forest_fires_bihar = non_forest_fires_bihar.iloc[:, np.r_[0,1,5,6,8,11,12,15:18]]

##Save both forest_fire & non-forest_fire information
today_date = date.today().strftime('%d-%m-%Y')
forest_fire.to_excel('forest_fire_'+str(today_date)+'.xlsx', index=False)
non_forest_fires_bihar.to_excel('non_forest_fire_'+str(today_date)+'.xlsx', index=False)


##plot for reference
fig, ax1 = plt.subplots()
forest.plot(facecolor='none', edgecolor='k', linewidth=0.3, ax=ax1)
forest_fire.plot(facecolor='none', edgecolor='red', markersize=0.01, ax=ax1)
