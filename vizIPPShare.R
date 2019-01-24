### Visualize IPP Share 

pathtoShp = "/home/nicholas/Documents/RetailMarketProject/USStateMap/cb_2017_us_state_500k.shp"

vizIPPShare = function(df, pathtoShp) {

  if(! "sp" %in% installed.packages()){
    install.packages("sp")
    } 
    library(sp)

  if(! "rgdal" %in% installed.packages()){
    install.packages("rgdal")
    } 
    library(rgdal)

  shpfile = pathtoShp
  lower48 = c('AL', 'VA', 'WV', 'AZ', 'AR', 'TN', 'NJ', 'MD', 'ME', 'MT', 'SD', 'WY', 'NC', 'SC', 'NY', 'LA', 'OH', 'IL', 'CT', 'WI', 'MI', 'DE', 'PA', 'NM', 'TX', 'KS', 'MO', 'OK', 'MA', 'FL', 'GA', 'NH', 'VT', 'ID', 'OR', 'IN', 'KY', 'ND', 'MN', 'MS', 'RI', 'NV', 'CA', 'WA', 'UT', 'DC', 'CO', 'IA', 'NE')

  s = readOGR(shpfile)
  ss = s[s$STUSPS %in% lower48,]

  set_col_regions(heat.colors(20))
  a = seq(0, 1, length.out=21)
  
  for (i in seq_along(unique(df$year))){
    temp = df[df$year == unique(df$year)[i] & df$state %in% lower48,]
    sg = sp::merge(ss, temp, by.x = 'STUSPS', by.y = 'state')  
    print(spplot(sg, zcol= 'ipp2util', at = a, main=list(label=unique(df$year)[i],cex=3)))
  }
}
