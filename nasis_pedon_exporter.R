library(soilDB)
library(RODBC)

con <- soilDB:::.openNASISchannel()

phzn <- dput(colnames(sqlQuery(con, "select * from phorizon")))

pn <- dput(colnames(sqlQuery(con, "select * from pedon"))) 

dput(pn)
cat(pn, sep = ",")
cat(rep('FIELD', length(pn)), sep=",")

sn <- dput(colnames(sqlQuery(con, "select * from siteobs
                                   inner join site ON site.siteiid = siteobs.siteiidref")))
dput(sn)
cat(sn, sep = ",")
cat(rep('FIELD', length(sn)), sep=",")



sn2 <- dput(colnames(sqlQuery(con, "select * from 
        nasissite   ns                                         INNER JOIN
        nasisgroup  ng ON ng.nasissiteiidref = ns.nasissiteiid INNER JOIN 
        site        s  ON s.grpiidref        = ng.grpiid       LEFT OUTER JOIN
        sitetext    st ON st.siteiidref      = s.siteiid       AND st.textsubcat      = 'Undisclosed Location'
        INNER JOIN siteobs so ON so.siteiidref  = s.siteiid" )))
dput(sn2)
cat(sn2, sep = ",")
cat(rep('FIELD', length(sn2)), sep=",")

phth <- dput(colnames(sqlQuery(con, "select * from petaxhistory")))
dput(phth)
cat(phth, sep = ",")
cat(rep('FIELD', length(phth)), sep=",")

pht <- dput(colnames(sqlQuery(con, "select * from phtexture
                                    inner join phtexturemod ON phtexture.phtiid = phtexturemod.phtiidref ")))
dput(pht)
cat(pht, sep = ",")
cat(rep('FIELD', length(pht)), sep=",")

phf <- dput(colnames(sqlQuery(con, "select * from phfrags")))
dput(phf)
cat(phf, sep = ",")
cat(rep('FIELD', length(phf)), sep=",")

phcn <- dput(colnames(sqlQuery(con, "select * from phcolor")))
dput(phcn)
cat(phcn, sep = ",")
cat(rep('FIELD', length(phcn)), sep=",")

phdf <- dput(colnames(sqlQuery(con, "select * from pediagfeatures")))
dput(phdf)
cat(phdf, sep = ",")
cat(rep('FIELD', length(phdf)), sep=",")
# EXEC SQL 
# SELECT 
#  [CASTED COLUMN NAMES]
# FROM
#  [BASE TABLE]
#  [JOINS];.
#  
#TEMPLATE basic SEPARATOR "|" AT LEFT FIELD WIDTH UNLIMITED SEPARATOR "",
#FIELD, ... {# columns times} ... .
#PAGE WIDTH UNLIMITED LENGTH UNLIMITED.
#
#SECTION WHEN AT START                              
#DATA
#USING basic
# [QUOTED COLUMN HEADERS].
#END SECTION.
#
#SECTION
#DATA
#USING BASIC
#[CLEAN COLUMN NAMES, comma separated]
#END SECTION.
