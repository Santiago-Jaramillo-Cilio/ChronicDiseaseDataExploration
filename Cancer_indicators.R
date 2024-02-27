library(tidyverse)

Cancer_indicators <- read_csv("U.S._Chronic_Disease_Indicators__Cancer.csv")

head(Cancer_indicators)
str(Cancer_indicators)
colnames(Cancer_indicators)

# Analyze the incidence of colorectal cancer by state
Incidence_Colorectal_Cancer_by_State <- Cancer_indicators %>%
  filter (grepl("colorectal", Question, ignore.case = TRUE)) %>% 
  filter(LocationDesc != "United States") %>% 
  group_by(LocationDesc) %>% 
  summarize(Average_DataValue = round(mean(DataValue, na.rm = TRUE),0))

view(Incidence_Colorectal_Cancer_by_State)

# Bar chart incidence of colorectal cancer by state
ggplot(data = Incidence_Colorectal_Cancer_by_State, aes(x = reorder(LocationDesc, -Average_DataValue), y = Average_DataValue)) +
  geom_bar(stat = "identity", fill = "SteelBlue") +
  theme_minimal() +
  labs(title = "Average Incidence of Colorectal Cancer by State",
       x = "State",
       y = "Average Incidence Rate 2008-2020") +
  coord_flip() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# This script filters data for colorectal cancer cases, excluding the United States as a whole. It then groups the data by location and year to calculate the highest incidence of colorectal cancer for each location.
Max_incidence_by_year <- Cancer_indicators %>%
  filter(grepl("colorectal", Question, ignore.case = TRUE)) %>%
  filter(LocationDesc != "United States") %>%
  group_by(LocationDesc, YearStart) %>%
  summarize(Total_Incidence = round(sum(DataValue, na.rm = TRUE), 0), .groups = 'drop') %>%
  group_by(LocationDesc) %>%
  summarize(Year_of_Max_Incidence = YearStart[which.max(Total_Incidence)],
            Max_Incidence = max(Total_Incidence))

View(Max_incidence_by_year)

# This script focuses on colorectal cancer incidences, excluding nationwide data. It aggregates the total incidence per location and year, then determines the year with the lowest total incidence for each location. 
Min_incidence_by_year <- Cancer_indicators %>%
  filter(grepl("colorectal", Question, ignore.case = TRUE)) %>%
  filter(LocationDesc != "United States") %>%
  group_by(LocationDesc, YearStart) %>%
  summarize(Total_Incidence = round(sum(DataValue, na.rm = TRUE), 0), .groups = 'drop') %>%
  group_by(LocationDesc) %>%
  summarize(Year_of_Min_Incidence = YearStart[which.min(Total_Incidence)],
            min_Incidence = min(Total_Incidence))

View(Min_incidence_by_year)


# Combine analysis for maximum, minimum, and average colorectal cancer incidence by location, excluding the United States as a whole.
Incidence_Analysis <- Cancer_indicators %>%
  filter(grepl("colorectal", Question, ignore.case = TRUE)) %>%
  filter(LocationDesc != "United States") %>%
  group_by(LocationDesc, YearStart) %>%
  summarize(Total_Incidence = round(sum(DataValue, na.rm = TRUE), 0), .groups = 'drop') %>%
  group_by(LocationDesc) %>%
  summarize(
    Year_of_Max_Incidence = YearStart[which.max(Total_Incidence)],
    Max_Incidence = max(Total_Incidence),
    Year_of_Min_Incidence = YearStart[which.min(Total_Incidence)],
    Min_Incidence = min(Total_Incidence),
    Average_Incidence = round(mean(Total_Incidence), 0)
  )

View(Incidence_Analysis)







  