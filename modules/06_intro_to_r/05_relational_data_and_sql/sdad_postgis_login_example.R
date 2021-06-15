library(RPostgreSQL)
library(sf)

# Create a Database Connection - you will normally not want to store your credentials here!
con <- dbConnect(
  drv = PostgreSQL(),
  dbname = "sdad",
  host = "postgis1",
  port = 5432,
  user = "example",
  password = "exampleexample"
)

# Use connection to query database. In this case we us sf::st_read because the table has a geography/geometry column we want to use.
arlington_county_tracts <- st_read(dsn = con,
                                   query = "SELECT *
                                            FROM gis_census_cb.cb_2018_51_tract_500k
                                            WHERE \"COUNTYFP\" = '013'")

# Plot just the geometry
plot(st_geometry(arlington_county_tracts))
# Plot one of the columns with the geometry
plot(arlington_county_tracts[, c("ALAND")])

# Writing tables.
# Everyone can write tables to the public schema. If you don't include a schema, it will assume "public".

# load some data
data("mtcars")

# write data.frame to the database
dbWriteTable(con, "example_mt_cars", mtcars, row.names = T)

# query to make sure it's there (here we use dbGetQuery instead of st_read, there is no geometry in this table)
dbGetQuery(con, "select * from public.example_mt_cars")

# Be a good citizen and delete your connections when finished
dbDisconnect(con)


