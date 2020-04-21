## load data into dataframes
NEI <- readRDS(".data/summarySCC_PM25.rds")
SCC <- readRDS(".data/Source_Classification_Code.rds")


## sum emissions by year
pm25_yr_totals <- aggregate(x = NEI$Emissions,
							by = list(NEI$year),
							FUN = sum)


# remove variables no longer needed
rm(NEI, SCC)


## set the graphics parameter to PNG graphics device
png(
	filename = "plot1.png",
	width = 600,
	height = 600,
	units = "px"
)

## define plot margins
## plot line chart
## annotate chart
## define axes
## add reference lines
par(mar = c(5, 5, 3, 2))
plot(
	pm25_yr_totals$Group.1,
	pm25_yr_totals$x,
	type = "b",
	lwd = 2,
	pch = 19,
	xaxt = "n",
	yaxt = "n",
	xlab = "Measurement Year",
	ylab = "Total Fine Particulate Matter (PM2.5)\n(Tons in Millions)",
	main = "Total Fine Particulate Matter (PM2.5) By Measurement Year"
)
axis(1, xaxp = c(1999, 2008, 3))
axis(
	2,
	at = c(3500000, 4500000, 5500000, 6500000, 7250000),
	labels = c(3.50, 4.50, 5.50, 6.50, 7.25)
)
abline(
	h = c(3500000, 4500000, 5500000, 6500000, 7250000),
	v = 1999:2008,
	col = "lightgray",
	lty = 3
)


# remove variables no longer needed
rm(pm25_yr_totals)

## close the PNG device
dev.off()