# Fire-Event-Analysis
The code is designed to analyse the crop residue burning events for the state of Bihar. The python code shared can be used to extract district specific fire events (In my case I have used State of Bihar, India) from the shapefile downloaded from NASA-FIRMS database. 
Additionaly, Landuse Landcover dataset can be used to distingush between the crop residue fire, forest fire and other anthroporgenic activities based fire events. Well, I haven't quite shown that in my codes here. One can simply extract the LU/LC property from tiff file using fire event lat/long data. The code is shown below
 ##The code to extract LU/LC properties based on fire event cordinates
 import rasterio as rio
 import pandas as pd
 import numpy as np
 LU_LC = rio.open('LU_LC.tif')
 data = LU_LC.read(1)
 row_index, col_index = LU_LC.index(Latitude of fire event, longitude of fire event)
 LU_LC_property = data[row_index,col_index]
 
 ##Alternatively one can use opensource softwares such as Q-GIS (Sample raste values features) to extract the LU_LC propoerties based on fire event coordinates  
 
The R-codes can be used to perform Exploratory Data Anlaysis to support policy makers in identifiying the overall yearly trend, peak burning periods, Fire hotposots for timely interventions to curb the event.

## Graphical Abstract summarising the analysis


![Raw Data](https://user-images.githubusercontent.com/83420459/152357591-5f7b04e2-880e-42e2-afbd-dffe3aa7ff5d.png)
