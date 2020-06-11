library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coal_SCCs <- SCC %>%
  filter(grepl("coal", EI.Sector, ignore.case=TRUE)) %>%
  select(SCC)

emissions_by_year <- NEI %>%
  filter(SCC %in% coal_SCCs$SCC) %>%
  group_by(year) %>%
  summarize(total_emissions = sum(Emissions))

emissions_by_year$year <- as.factor(emissions_by_year$year)

ggplot(emissions_by_year, aes(x=year, y=total_emissions)) + geom_bar(stat="identity") + labs(x="Year", y="PM2.5 Emissions (tons)") + ggtitle("US PM2.5 Emissions from Coal Related Sources")

dev.copy(png,'plot4.png')
dev.off()