library(soilDB)

analytes <- SDA_query("SELECT * from lab_analyte")

res <- lapply(analytes$analyte_abbrev, grepl, analytes$analyte_algorithm)
analyte.sub <- analytes[do.call('c', lapply(res, which)),]
analyte.sub$analyte_size_frac_base[is.na(analyte.sub$analyte_size_frac_base)] <- "NONE"

analyte.sub$pathString <- paste("NCSSC_BulkDensity", 
                                 analyte.sub$analyte_type, 
                                 analyte.sub$analyte_size_frac_base,
                                 analyte.sub$analyte_abbrev,
                                 sep = "/")
analyte.sub <- as.Node(analyte.sub)

library(networkD3)
par(mar=c(0,0,0,0))
useRtreeList <- ToListExplicit(analyte.sub, unname = TRUE)
radialNetwork(useRtreeList, fontSize = 18)
