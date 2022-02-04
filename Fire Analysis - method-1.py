# -*- coding: utf-8 -*-
"""
Created on Tue Sep 14 11:34:19 2021

@author: HP
"""

import pandas as pd
import geopandas as gpd
import numpy as np
import matplotlib.pyplot as plt
import rasterio
from rasterio.plot import show

##read the shapefile polygon
shapefile = gpd.read_file(r'C:/Users/HP/Desktop/data/IND_adm/PF AND PANCHYAT BOUNDARY/PANCHAYAT_BOUND_WITH_FOREST_ATTRIBUTES.shp')

##read the fire data file (MODIS)
modis_fire = gpd.read_file(r'C:/Users/HP/Desktop/AOD-PM2.5/Fire_data/Fire_data/fire_archive_M-C61_221546.shp')

##Overlay both the shapefiles retreivng all the original polygons 
data_overlay = gpd.sjoin(modis_fire, shapefile, how='left', op='intersects')

##Overlay both the shapes (Use how='differences' to inverse the selection)
data_overlay1 = gpd.overlay(modis_fire, shapefile,  how='intersect', keep_geom_type= False)

data_overlay.drop(['geometry'], axis=1).to_excel('C:/Users/HP/Desktop/AOD-PM2.5/Fire_data/analysis/modis_intersect.xlsx')

##read the fire data file (VIIRS)
viirs = gpd.read_file(r'C:/Users/HP/Desktop/AOD-PM2.5/Fire_data/Fire_data/fire_archive_SV-C2_221548.shp')
data_overlay = gpd.sjoin(shapefile, viirs, how='left', op='intersects')
data_overlay.drop(['geometry'], axis=1).to_excel('C:/Users/HP/Desktop/AOD-PM2.5/Fire_data/analysis/viirs_intersect.xlsx')


##read the fire data file (VIIRS_J1V)
viirs_jv = gpd.read_file(r'C:/Users/HP/Desktop/AOD-PM2.5/Fire_data/Fire_data/fire_nrt_J1V-C2_221547.shp')
data_overlay = gpd.sjoin(shapefile, viirs_jv, how='left', op='intersects')
data_overlay.drop(['geometry'], axis=1).to_excel('C:/Users/HP/Desktop/AOD-PM2.5/Fire_data/analysis/viirs_nrt_intersect.xlsx')
