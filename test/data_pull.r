# Data pull functions for baseballr

standings_dataset <- function(dates, division) {
  df <- tibble()

  for (i in dates) {
    bref_standings_on_date(date = i, division = division) %>%
      mutate(Date = i) -> data

    df <- bind_rows(df, data)
  }

  return(df)
}

batting_dataset <- function(date_list) {
  df <- tibble()

  for (i in date_list) {
    bref_daily_batter(t1 = i[1], t2 = i[2]) -> data
    df <- bind_rows(df, data)
  }
  return(df)
}
