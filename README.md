# Exploratory-Data-Analysis-Course-Project-2

Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the EPA National Emissions Inventory web site.

For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.

PM2.5 Emissions Data (\color{red}{\verb|summarySCC_PM25.rds|}summarySCC_PM25.rds): This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year. Here are the first few rows.


\color{red}{\verb|fips|}fips: A five-digit number (represented as a string) indicating the U.S. county
\color{red}{\verb|SCC|}SCC: The name of the source as indicated by a digit string (see source code classification table)
\color{red}{\verb|Pollutant|}Pollutant: A string indicating the pollutant
\color{red}{\verb|Emissions|}Emissions: Amount of PM2.5 emitted, in tons
\color{red}{\verb|type|}type: The type of source (point, non-point, on-road, or non-road)
\color{red}{\verb|year|}year: The year of emissions recorded
Source Classification Code Table (\color{red}{\verb|Source_Classification_Code.rds|}Source_Classification_Code.rds): This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever categories you think are most useful. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.

You can read each of the two files using the \color{red}{\verb|readRDS()|}readRDS() function in R. For example, reading in each file can be done with the following code:


as long as each of those files is in your current working directory (check by calling \color{red}{\verb|dir()|}dir() and see if those files are in the listing).
