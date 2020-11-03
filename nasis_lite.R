# convert local NASIS MSSQL database to SQLITE analogue
# 
library(DBI)
library(odbc) # driver to read MSSQL 
library(RSQLite) # driver to write SQLite
con <- dbConnect(odbc::odbc(), 
                 DSN = "nasis_local", 
                 UID = "NasisSqlRO",
                 PWD = "nasisRe@d0n1y365")
outcon <- dbConnect(RSQLite::SQLite(), "nasis_local.db")

res <- lapply(dbListTables(con), function(x) {
   print(x)
   suppressWarnings({q <- try(dbGetQuery(con, statement = sprintf("SELECT * FROM %s", x)))
   if (!inherits(q, 'try-error'))
      return(dbWriteTable(outcon, name = x, value = q, overwrite = TRUE))})
    print(sprintf("could not write %s", x))
  })

all(dbListTables(con) == dbListTables(outcon))

DBI::dbDisconnect(outcon)
DBI::dbDisconnect(con)

