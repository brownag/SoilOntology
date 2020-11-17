# convert local NASIS MSSQL database to SQLITE analogue
# 
library(DBI)
library(RODBC) # driver to read MSSQL 
#library(odbc) # note: still have nanodbc errors for tables with long data columns e.g. calculations
library(RSQLite) # driver to write SQLite

con <- soilDB:::.openNASISchannel()
outcon <- dbConnect(RSQLite::SQLite(), "nasis_local.db")

res <- lapply(RODBC::sqlTables(con)$TABLE_NAME, function(x) {
   print(x)
   suppressWarnings({q <- try(sqlQuery(con, sprintf("SELECT * FROM %s", x)))
   if (inherits(q, 'data.frame'))
      return(dbWriteTable(outcon, name = x, value = q, overwrite = TRUE))})
    print(sprintf("could not write %s", x))
  })

all(dbListTables(con) == dbListTables(outcon))

DBI::dbDisconnect(outcon)
DBI::dbDisconnect(con)


suppressWarnings({q <- try(sqlQuery(con, sprintf("SELECT * FROM %s", "pedon")))

tblz <- RODBC::sqlTables(con)
tblz$TABLE_NAME[grepl('pedon',tblz$TABLE_NAME)]
