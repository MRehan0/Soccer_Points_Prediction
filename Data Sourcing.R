# Load necessary libraries
library(worldfootballR)
library(dplyr)

# Function to fetch and save soccer statistics
get_soccer_stats <- function(country = "ENG", season_end_year = 2022, tier = "1st", stat_type = "defense", save_filename = "soccer_stats.csv") {
  
  # Fetch the data based on the input parameters
  data <- fb_season_team_stats(
    country = country,
    gender = "M",  # Set gender as Male (can modify to make gender interchangeable too if needed)
    season_end_year = season_end_year,
    tier = tier,
    stat_type = stat_type
  )
  
  # Clean the data by selecting the necessary columns
  if (stat_type == "keeper") {
    data_cleaned <- data %>%
      select(Squad, Save_percent, CS_percent, PKatt_Penalty_Kicks, Save_percent_Penalty_Kicks)
  } else {
    data_cleaned <- data %>%
      select(-Competition_Name, -Gender, -Country, -Season_End_Year, -Team_or_Opponent, -Num_Players, -Mins_Per_90)
  }
  
  # Save the cleaned data to a CSV file
  write.csv(data_cleaned[1:20, ], save_filename, row.names = FALSE)
  
  return(data_cleaned[1:20, ])
}

# Example Usage:
# Get defense statistics for Premier League 2023 season
defense_data <- get_soccer_stats(country = "ENG", season_end_year = 2023, tier = "1st", stat_type = "defense", save_filename = "prem_2023_defense.csv")

# Get passing statistics for Premier League 2022 season
passing_data <- get_soccer_stats(country = "ENG", season_end_year = 2022, tier = "1st", stat_type = "passing", save_filename = "prem_2022_passing.csv")

# Get goalkeeper statistics for Premier League 2022 season
keeper_data <- get_soccer_stats(country = "ENG", season_end_year = 2022, tier = "1st", stat_type = "keeper", save_filename = "prem_2022_keeper_stats.csv")
