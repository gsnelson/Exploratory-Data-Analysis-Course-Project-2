## import required libraries
library(tidyverse)
library(sqldf)
library(patchwork)


## load data into dataframes
NEI <- readRDS(".data/summarySCC_PM25.rds")
SCC <- readRDS(".data/Source_Classification_Code.rds")


## filter the SCC dataframe to capture motor vehicle emissions
## filter on the ONROAD type variable
vehicle_SCCs <-
	filter(SCC, Data.Category == "Onroad")


## perform an index/match to filter the NEI dataframe on motor vehicle emission SCC's
emissions <- filter(NEI, SCC %in% vehicle_SCCs$SCC)


## filter on Baltimore City/LA County fips code
my_subset <- filter(emissions, fips == "24510" | fips == "06037")


## aggregate vehicle emissions by sum and mean
my_aggregs <- sqldf(
	"select year, fips,
      avg(Emissions) `emissions.mean`,
      sum(Emissions) `emissions.sum`
      from `my_subset`
      group by fips, year"
)


# remove variables no longer needed
rm(NEI, SCC, vehicle_SCCs, emissions, my_subset)


## set the graphics parameter to PNG graphics device
png(
	filename = "plot6.png",
	width = 1600,
	height = 800,
	units = "px"
)


## plot total emissions by year by location
plot1 <-
	ggplot(my_aggregs, aes(x = year, y = emissions.sum, color = fips)) +
	geom_line(lwd = 1.5) + geom_point(
		shape = 21,
		size = 3,
		fill = "white",
		show.legend = TRUE
	) +
	scale_x_continuous(breaks = c(1999, 2002, 2005, 2008)) +
	xlab("") + ylab("Emissions (in Tons)") +
	scale_color_discrete(labels = c("LA County", "Baltimore City")) +
	labs(color = "Location") +
	ggtitle(
		"Total Fine Particulate Matter (PM2.5) Emissions From Motor Vehicle Sources\nCity of Baltimore, Maryland and Los Angeles County, California"
	) +
	theme(legend.position = c(1, 0),
		  legend.justification = c(1.4, -2.43)) +
	theme(legend.background = element_rect(fill = "white", color = "black"))


## plot mean emissions by year by location
plot2 <-
	ggplot(my_aggregs, aes(x = year, y = emissions.mean, color = fips)) +
	geom_line(lwd = 1.5) + geom_point(
		shape = 21,
		size = 3,
		fill = "white",
		show.legend = TRUE
	) +
	scale_x_continuous(breaks = c(1999, 2002, 2005, 2008)) +
	xlab("") + ylab("Emissions (in Tons)") +
	scale_color_discrete(labels = c("LA County", "Baltimore City")) +
	labs(color = "Location") +
	ggtitle(
		"Mean Fine Particulate Matter (PM2.5) Emissions From Motor Vehicle Sources\nCity of Baltimore, Maryland and Los Angeles County, California"
	) +
	theme(legend.position = c(1, 0),
		  legend.justification = c(7.13,-4.25)) +
	theme(legend.background = element_rect(fill = "white", color = "black")) +
	scale_y_continuous(breaks = c(0, 5, 10, 15, 20, 30, 50, 75, 100))


## use patchwork to combine charts
plot1 + plot2

# remove variables no longer needed
rm(my_aggregs, plot1, plot2)


## close the PNG device
dev.off()
