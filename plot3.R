library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

emissions_by_year <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year, type) %>%
  summarize(total_emissions = sum(Emissions))

emissions_by_year$year <- as.factor(emissions_by_year$year)

ggplot(emissions_by_year, aes(x=year, y=total_emissions)) + geom_bar(stat="identity") + facet_grid(. ~ type) + labs(x="Year", y="PM2.5 Emissions (tons)") + ggtitle("Baltimore City PM2.5 Emissions by Type")

dev.copy(png,'plot3.png')
dev.off()
