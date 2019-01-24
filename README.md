# eiaGenerationCapacity
Tools for working with EIA Generation Capacity Data  

getEIAStateGenCap.R contains the function `getGenCap()`.    
calcIPPGenCapShare.R contains the function `calcIPPShare()`.  
vizIPPShare.R contains the function `vizIPPShare()`.  

Source each of the files as so.  

```{r}
source('getEIAStateGenCap.R')  
source('calcIPPGenCapShare.R')
source('vizIPPShare.R')
```  

The function `getGenCap()` takes no arguments and is hardcoded with the EIA URL distribnuting the generation capacity data.  Specifically, the function is getting the **Existing Nameplate and Net Summer Capacity by Energy Source, Producer Type and State (EIA-860)** and returns the data as a R data.frame.  Assign `getGenCap()` to some varaible name like the following.  

```{r}
d = getGenCap()
```  

The function `calcIPPShare()` takes the dataframe returned by `getGenCap()` and returns a state level dataframe with two new variables approximating the share of generation capacity owned by independent power producers in each state in each year.  The first `ipp2util` gives the ratio of IPP generation capacity to IPP plus utility generation capacity.  The second `ipp2total` gives the ratio of IPP generation capcity to total electric industry capacity.  Simply pass `d` to the function and assign it to a new variable, like `g`.  

```{r}
g = calcIPPShare(d)
```  

The function `vizIPPShare()` can be used to produce a map time series when combined with the [Census Bureau 500k state shapefile](https://www.census.gov/geo/maps-data/data/cbf/cbf_state.html). Download the zip archieve and extract the files locally.  Pass the path to the .shp file to the `vizIPPShare()` function along with the dataframe `g`.  For example, the shape files are saved at the following location on my machine.  

`/home/nicholas/Documents/RetailMarketProject/USStateMap/cb_2017_us_state_500k.shp`  

```{r}
pathtoShp = "/home/nicholas/Documents/RetailMarketProject/USStateMap/cb_2017_us_state_500k.shp"
vizIPPShare(g, pathtoShp)
```  

