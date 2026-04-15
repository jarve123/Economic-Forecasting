## ----setup, include=FALSE-----------------
knitr::opts_chunk$set(echo = TRUE)


## -----------------------------------------
library(dplyr)

pl <- readRDS("pl_clean.rds")
ll <- readRDS("ll_clean.rds")
sa <- readRDS("sa_clean.rds")
bl <- readRDS("bl_clean.rds")

pl_team_match_df <- readRDS("pl_team_match_df.rds")
ll_team_match_df <- readRDS("ll_team_match_df.rds")
sa_team_match_df <- readRDS("sa_team_match_df.rds")
bl_team_match_df <- readRDS("bl_team_match_df.rds")

check_alignment <- function(clean_df, team_match_df, league_name) {
  book_names <- sort(unique(c(clean_df$HomeTeam, clean_df$AwayTeam)))
  model_names <- sort(unique(c(team_match_df$team, team_match_df$opponent)))
  
  cat("\n====================\n")
  cat(league_name, "\n")
  cat("====================\n")
  
  cat("\nIn clean but not in team_match_df:\n")
  print(setdiff(book_names, model_names))
  
  cat("\nIn team_match_df but not in clean:\n")
  print(setdiff(model_names, book_names))
}


## -----------------------------------------
check_alignment(pl, pl_team_match_df, "PL")
check_alignment(ll, ll_team_match_df, "LL")
check_alignment(sa, sa_team_match_df, "SA")
check_alignment(bl, bl_team_match_df, "BL")


## -----------------------------------------
pl_team_map <- c(
  "Man City" = "Manchester City",
  "Man United" = "Manchester United",
  "Newcastle" = "Newcastle United",
  "Nott'm Forest" = "Nottingham Forest",
  "West Brom" = "West Bromwich Albion",
  "Wolves" = "Wolverhampton Wanderers"
)

ll_team_map <- c(
  "Ath Bilbao" = "Athletic Club",
  "Ath Madrid" = "Atletico Madrid",
  "Betis" = "Real Betis",
  "Celta" = "Celta Vigo",
  "Espanol" = "Espanyol",
  "Huesca" = "SD Huesca",
  "La Coruna" = "Deportivo La Coruna",
  "Sociedad" = "Real Sociedad",
  "Sp Gijon" = "Sporting Gijon",
  "Valladolid" = "Real Valladolid",
  "Vallecano" = "Rayo Vallecano"
)

sa_team_map <- c(
  "Milan" = "AC Milan",
  "Parma" = "Parma Calcio 1913",
  "Spal" = "SPAL 2013"
)

bl_team_map <- c(
  "Bielefeld" = "Arminia Bielefeld",
  "Dortmund" = "Borussia Dortmund",
  "Ein Frankfurt" = "Eintracht Frankfurt",
  "FC Koln" = "FC Cologne",
  "Fortuna Dusseldorf" = "Fortuna Duesseldorf",
  "Greuther Furth" = "Greuther Fuerth",
  "Hamburg" = "Hamburger SV",
  "Hannover" = "Hannover 96",
  "Heidenheim" = "FC Heidenheim",
  "Hertha" = "Hertha Berlin",
  "Leverkusen" = "Bayer Leverkusen",
  "M'gladbach" = "Borussia M.Gladbach",
  "Mainz" = "Mainz 05",
  "Nurnberg" = "Nuernberg",
  "RB Leipzig" = "RasenBallsport Leipzig",
  "St Pauli" = "St. Pauli",
  "Stuttgart" = "VfB Stuttgart"
)

apply_team_mapping <- function(df, team_map) {
  df %>%
    mutate(
      HomeTeam = recode(HomeTeam, !!!team_map),
      AwayTeam = recode(AwayTeam, !!!team_map)
    )
}


## -----------------------------------------
pl <- apply_team_mapping(pl, pl_team_map)
ll <- apply_team_mapping(ll, ll_team_map)
sa <- apply_team_mapping(sa, sa_team_map)
bl <- apply_team_mapping(bl, bl_team_map)

check_alignment(pl, pl_team_match_df, "PL")
check_alignment(ll, ll_team_match_df, "LL")
check_alignment(sa, sa_team_match_df, "SA")
check_alignment(bl, bl_team_match_df, "BL")

