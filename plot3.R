## import required libraries
library(ggplot2)

## load data into dataframes
NEI <- readRDS(".data/summarySCC_PM25.rds")
SCC <- readRDS(".data/Source_Classification_Code.rds")


## subset on Baltimore City fips code
balti <- subset(NEI, fips == "24510")


## create a dataframe with the sum of Baltimore City emissions by year by type
pm25_balti_totals <- aggregate(
	x = balti$Emissions,
	by = list(balti$year, balti$type),
	FUN = sum
)


## give the variables meaningful names
names(pm25_balti_totals) <- c("year", "type", "emissions")


## order the dataframe by type and year
## done to group the type facets in the plot so the point and road types
## are paired together
pm25_balti_totals$type <-
	factor(pm25_balti_totals$type,
		   levels = c("POINT", "NONPOINT", "ON-ROAD", "NON-ROAD"))
pm25_balti_totals[order(pm25_balti_totals$type, pm25_balti_totals$year),]


# remove variables no longer needed
rm(NEI, SCC)


## set the graphics parameter to PNG graphics device
png(
	filename = "plot3.png",
	width = 800,
	height = 400,
	units = "px"
)


## plot the data using facets
ggplot(pm25_balti_totals, aes(x = year, y = emissions)) +
	geom_line(linetype = 2, size = 1) + geom_point(shape = 21, size = 3, fill = "red") +
	facet_grid(cols = vars(type)) + scale_x_continuous(breaks = c(1999, 2002, 2005, 2008)) +
	scale_y_continuous(breaks = c(0, 250, 500, 750, 1000, 1250, 1500, 1750, 2000, 2250)) +
	ggtitle(
		"Total Fine Particulate Matter (PM2.5) By Measurement Year By Type\nCity of Baltimore, Maryland"
	) +
	xlab("") + ylab("Emissions\n(in Tons)") + theme(axis.text.x = element_text(
		angle = 45,
		hjust = 1,
		vjust = 1
	))


# remove variables no longer needed
rm(balti, pm25_balti_totals)

## close the PNG device
dev.off()
