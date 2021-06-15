library(RPostgreSQL)
library(sf)

con <- dbConnect(
  drv = PostgreSQL(),
  dbname = "sdad",
  host = "postgis1",
  port = 5432,
  user = "example",
  password = "exampleexample"
)

arlington_county_tracts <- st_read(dsn = con,
                                   query = "SELECT *
                                            FROM gis_census_cb.cb_2018_51_tract_500k
                                            WHERE \"COUNTYFP\" = '013'")

dbDisconnect(con)

plot(st_geometry(arlington_county_tracts))

plot(arlington_county_tracts[, c("ALAND")])
