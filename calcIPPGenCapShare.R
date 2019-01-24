### Function to calculate two different measure of IPP ownership share of generation capacity 

calcIPPShare = function(df) {

  a = aggregate(df$nameplate, by = list(df$year, df$state, df$producer, df$fuel), FUN=sum)
  names(a) = c('year', 'state', 'producer', 'fuel', 'capacity')
  allfuel = a[a$fuel == "All Sources",]

  ### There are even two debateable measures here ipp/(ipp + util) or ipp/total

  utils = allfuel[allfuel$producer == "Electric Generators, Electric Utilities",]
  total = allfuel[allfuel$producer == "Total Electric Power Industry",]
  ipp = allfuel[allfuel$producer == "Electric Generators, Independent Power Producers",]
  names(utils) = c("year", "state", "producer", "fuel", "utilcapacity")
  names(total) = c("year", "state", "producer", "fuel", "totalcapacity")
  names(ipp) = c("year", "state", "producer", "fuel", "ippcapacity")
  utils = utils[c("year", "state", "utilcapacity")]
  total = total[c("year", "state", "totalcapacity")]
  ipp = ipp[c("year", "state", "ippcapacity")]

  gen = merge(ipp, utils, all=TRUE)
  gen = merge(gen, total, all=TRUE)

  gen$ippcapacity[is.na(gen$ippcapacity)] = 0
  gen$utilcapacity[is.na(gen$utilcapacity)] = 0

  gen$ipp2util = gen$ippcapacity/(gen$ippcapacity + gen$utilcapacity)
  gen$ipp2total = gen$ippcapacity/gen$totalcapacity
  gen
}
