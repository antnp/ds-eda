# plot6.R

setwd("~/Dropbox/code/coursera/ds-eda/assign2")

library(dplyr)
library(ggplot2)
library(stringr)

# Load data
NEI <- readRDS("./data/exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./data/exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds")

# Merge the NEI and SCC data
NEISCC <- merge(NEI, SCC, by = "SCC")

# Compare emissions from motor vehicle sources in Baltimore City with 
# emissions from motor vehicle sources in Los Angeles County (fips == '06037')

by_year_fips_type <- NEISCC %>%
  group_by(year, fips, type) %>%
  filter((fips == "24510" | fips == "06037") & type == "ON-ROAD") %>%
  summarise(
    rec_count = n(),
    sum_emission = sum(Emissions)
  )

# Add label column
by_year_fips_type$county <- ifelse(by_year_fips_type$fips == "24510", "Baltimore City", 
                                       "Los Angeles County")

png("plot6.png")
ggplot(data = by_year_fips_type, aes(year, sum_emission, color = county)) +
  geom_line() + geom_point() +
  xlab("Year") + ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle("Motor Vehicle Emissions by County")
dev.off()
