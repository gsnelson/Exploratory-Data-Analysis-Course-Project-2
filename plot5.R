## import required libraries
library(tidyverse)


## load data into dataframes
NEI <- readRDS(".data/summarySCC_PM25.rds")
SCC <- readRDS(".data/Source_Classification_Code.rds")


## filter the SCC dataframe to capture motor vehicle emissions
## filter on the ONROAD type variable
vehicle_SCCs <-
	filter(SCC, Data.Category == "Onroad")


## perform an index/match to filter the NEI dataframe on coal combustion SCC's
emissions <- filter(NEI, SCC %in% vehicle_SCCs$SCC)


## filter on Baltimore City fips code
balti_only <- filter(emissions, fips == "24510")


# remove variables no longer needed
rm(NEI, SCC, vehicle_SCCs)


## set the graphics parameter to PNG graphics device
png(
	filename = "plot5.png",
	width = 600,
	height = 600,
	units = "px"
)


ggplot(balti_only, aes(x = factor(year), y = log10(Emissions))) +
	geom_boxplot(outlier.size = 1.5, outlier.shape = 21) +
	stat_summary(
		fun = "mean",
		geom = "point",
		shape = 23,
		size = 3,
		fill = "red"
	) +
	ggtitle(
		"Median Fine Particulate Matter (PM2.5) Emissions From Motor Vehicle Sources\nCity of Baltimore, Maryland"
	) +
	xlab("")


# remove variables no longer needed
rm(emissions, balti_only)

## close the PNG device
dev.off()
