### Calculate the percentage of IPP per year per state
### The IPP proxy for wholesale competition

getGenCap = function() {

if(! "RCurl" %in% installed.packages()){
  install.packages("RCurl")
  } 
  library(RCurl)

  if(! "XML" %in% installed.packages()){
  install.packages("XML")
  } 
  library(XML)

  if(! "readxl" %in% installed.packages()){
  install.packages("XML")
  } 
  library(readxl)

  u = "https://www.eia.gov/electricity/data/state/"
  t = getURLContent(u)
  h = htmlParse(t)
  n = getNodeSet(h, '//table/tr/td/table/tr/td[3]/a[@title="1990 - 2017 Existing Nameplate and Net Summer Capacity by Energy Source, Producer Type and State (EIA-860)  "]')
  l = xmlGetAttr(n[[1]], 'href')
  pat = strsplit(l, "\\.")[[1]][1]
  ext = strsplit(l, "\\.")[[1]][2]
  uu = paste0(u, l)
  tmp = tempfile(pattern = pat, fileext = paste0('.', ext))
  download.file(uu, tmp)
  sheet = excel_sheets(tmp)[[1]]
  d = read_excel(tmp, sheet=sheet)
  
  ## Including some basic data cleaning
  names(d) = gsub("\\.", "", names(d))
  names(d) = tolower(names(d))
  names(d) = c('year', 'state', 'producer', 'fuel', 'gen', 'facil', 'nameplate', 'summer')
  numvars = c('nameplate', 'summer')
  d[numvars] = lapply(d[numvars], function(x) gsub(",", "", x))
  d[numvars] = lapply(d[numvars], as.numeric)
  d[numvars][is.na(d[numvars])] = 0
  d

}







