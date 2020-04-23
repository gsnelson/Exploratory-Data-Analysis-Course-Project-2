## import required libraries
library(tidyverse)
library(sqldf)


## load data into dataframes
NEI <- readRDS(".data/summarySCC_PM25.rds")
SCC <- readRDS(".data/Source_Classification_Code.rds")


## filter the SCC dataframe to capture coal combustion activities
## filtered on the EI.Sector variables that started with "Fuel Comb" and ended
## with "Coal
coal_SCCs <-
	filter(SCC,
		   str_starts(EI.Sector, "Fuel Comb") &
		   	str_ends(EI.Sector, "Coal"))


## perform an index/match to filter the NEI dataframe on coal combustion SCC's
coal_combustion <- filter(NEI, SCC %in% coal_SCCs$SCC)


## aggregate emissions by sum and mean
coal_combustion_by_type <- sqldf(
	"select year, type,
      avg(Emissions) `Emissions.Mean`,
      sum(Emissions) `Emissions.Sum`
      from `coal_combustion`
      group by type, year"
)


# remove variables no longer needed
rm(NEI, SCC, coal_SCCs)


## set the graphics parameter to PNG graphics device
png(
	filename = "plot4.png",
	width = 600,
	height = 400,
	units = "px"
)


## plot the data using facets
ggplot(coal_combustion_by_type, aes(x = year, y = Emissions.Sum)) +
	geom_line(linetype = 1, size = 1.5) +
	geom_point(
		shape = 21,
		size = 3,
		fill = "white",
		show.legend = TRUE
	) +
	scale_x_continuous(breaks = c(1999, 2002, 2005, 2008)) +
	xlab("") + ylab("Emissions\n(Tons in Thousands)") +
	facet_grid(cols = vars(type)) +
	scale_y_continuous(
		breaks = c(
			"0" = 0,
			"50" = 50000,
			"100" = 100000,
			"300" = 300000,
			"400" = 400000,
			"500" = 500000,
			"550" = 550000
		)
	) + ggtitle(
		"Total Fine Particulate Matter (PM2.5) Emissions From Coal Combustion-Related Sources\nUnited States of America"
	)


# remove variables no longer needed
rm(coal_combustion, coal_combustion_by_type)

## close the PNG device
dev.off()
