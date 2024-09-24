library(worldfootballR)
prem_2024_shooting <- fb_season_team_stats(country = "ENG", gender = "M", season_end_year = "2024", tier = "1st", stat_type = "shooting")
prem_2024_shooting$rounded_shotsper90 <- round(prem_2024_shooting$Sh_per_90_Standard)

data_2024 <- prem_2024_shooting[, 5:ncol(prem_2024_shooting)]



df <- data_2024[, c(1, 19, 22)]

For <- df[1:20, ]
Against <- df[21:40, ]
new_row_names <- gsub("vs ", "", Against$Squad)
Against$Squad <- new_row_names
rownames(Against) <- new_row_names

Team_A <- readline(prompt = "Enter First team: ")

Team_B <- readline(prompt = "Enter Second team: ")

teamA_xG <- mean(c(For[which(For$Squad == Team_A), 2], 
                   Against[which(Against$Squad == Team_B) , 2]))

teamB_xG <- mean(c(For[which(For$Squad == Team_B), 2], 
                   Against[which(Against$Squad == Team_A) , 2]))


teamA_shots <- round(mean(c(For[which(For$Squad == Team_A), 3], 
                            Against[which(Against$Squad == Team_B) , 3])))

teamB_shots <- round(mean(c(For[which(For$Squad == Team_B), 3], 
                            Against[which(Against$Squad == Team_A) , 3])))
num_matches <- 100
winners <- numeric(num_matches)
for (i in 1:num_matches) {
  n1 <- runif(teamA_shots, min = 0, max = 1)
  n2 <- runif(teamB_shots, min = 0, max = 1)
  
  teamA_goals <- sum(n1 < teamA_xG)
  teamB_goals <- sum(n2 < teamB_xG)
  
  winners[i] <- teamA_goals - teamB_goals
}

result <- sign(round(mean(winners)))

if (result == -1) {
  print(paste(Team_B , "wins"))
} else if (result == 0) {
  print("It's a draw")
} else if (result == 1) {
  print(paste(Team_A ,  "wins"))
}






