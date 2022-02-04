# -*- coding: utf-8 -*-
"""
Created on Tue Dec  8 13:07:13 2020

@author: HP
"""

import geopandas as gpd
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

bihar_shp =gpd.read_file('C:/Users/HP/Desktop/data/IND_adm/PF AND PANCHYAT BOUNDARY/PANCHAYAT_BOUND_WITH_FOREST_ATTRIBUTES.shp', mode='r')
f1= gpd.read_file('C:/Users/HP/Desktop/data/Fire_count_Nov/7th-11th Dec/7th-11th/J1_VIIRS_C2_South_Asia_7d.shp', mode='r')
f2= gpd.read_file('C:/Users/HP/Desktop/data/Fire_count_Nov/7th-11th Dec/7th-11th/MODIS_C6_South_Asia_7d.shp', mode='r')
f3= gpd.read_file('C:/Users/HP/Desktop/data/Fire_count_Nov/7th-11th Dec/7th-11th/SUOMI_VIIRS_C2_South_Asia_7d.shp', mode='r')
forest_shp = gpd.read_file('C:/Users/HP/Desktop/data/IND_adm/PF AND PANCHYAT BOUNDARY/PF_BOUNDARY_2019.shp',mode='r')

new_append = f1.append(f2).append(f3)
new_append.reset_index(inplace=True)


combined_fire = gpd.overlay(new_append,bihar_shp,how='intersection')
combined_fire.drop('index',axis=1,inplace=True)
combined_fire['serial']=np.arange(0,len(combined_fire))
comb_fire_dataframe =pd.DataFrame(combined_fire)
comb_fire_dataframe.sort_values(by=['serial'], inplace=True)
forest_shp.to_crs(epsg=4326, inplace=True)
new_fire_comb =gpd.overlay(combined_fire,forest_shp,how='intersection')
forst_df =pd.DataFrame(new_fire_comb)


forest_index= forst_df['serial'].to_numpy().tolist()
final = comb_fire_dataframe[~comb_fire_dataframe['serial'].isin(forest_index)]
final = final[final['ACQ_DATE']!='2020-11-30']
final.to_excel('Final_output.xlsx', index=False,sheet_name='COUNT')

block_count = final[['LATITUDE','LONGITUDE','BLK_NAME','DIST_NAM_1']].groupby(['BLK_NAME','DIST_NAM_1']).agg(['count'])

