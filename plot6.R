library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

emissions_by_year <- NEI %>%
  filter(fips %in% c("24510", "06037") & type == "ON-ROAD") %>%
  group_by(year, fips) %>%
  summarize(total_emissions = sum(Emissions))

emissions_by_year$year <- as.factor(emissions_by_year$year)
emissions_by_year$county_name <- factor(emissions_by_year$fips, levels=c("06037", "24510"), labels=c("Los Angeles County", "Baltimore City")) 

ggplot(emissions_by_year, aes(x=year, y=total_emissions)) + 
  geom_bar(stat="identity", aes(fill=county_name), position = "dodge") +
  guides(fill=guide_legend(title=NULL)) +
  labs(x="Year", y="PM2.5 Emissions (tons)") +
  ggtitle("Vehicle PM2.5 Emissions - Baltimore City and LA County") +
  theme(legend.position="bottom")


dev.copy(png,'plot6.png')
dev.off()