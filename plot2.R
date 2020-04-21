## load data into dataframes
NEI <- readRDS(".data/summarySCC_PM25.rds")
SCC <- readRDS(".data/Source_Classification_Code.rds")


## subset on Baltimore City fips code
balti <- subset(NEI, fips == "24510")


## sum Baltimore City emissions by year
pm25_balti_totals <- aggregate(
	x = balti$Emissions,
	by = list(balti$year),
	FUN = sum,
	drop = TRUE
)


# remove variables no longer needed
rm(NEI, SCC)


## set the graphics parameter to PNG graphics device
png(
	filename = "plot2.png",
	width = 800,
	height = 600,
	units = "px"
)


## define plot margins
## plot line chart
## annotate chart
## define axes
## add reference lines
par(mar = c(5, 6, 4, 1), las = 1)
plot(
	pm25_balti_totals$Group.1,
	pm25_balti_totals$x,
	type = "b",
	lwd = 2,
	pch = 19,
	xaxt = "n",
	yaxt = "n",
	xlab = "Measurement Year",
	ylab = "Total Fine Particulate Matter (PM2.5) (in tons)\n",
	main = "Total Fine Particulate Matter (PM2.5) By Measurement Year\nCity of Baltimore, Maryland"
)
axis(1, xaxp = c(1999, 2008, 3))
axis(2)
abline(
	h = c(2000, 2200, 2400, 2600, 2800, 3000, 3200),
	v = 1999:2008,
	col = "lightgray",
	lty = 3
)


# remove variables no longer needed
rm(balti, pm25_balti_totals)

## close the PNG device
dev.off()