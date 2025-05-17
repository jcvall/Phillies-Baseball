# Data pull functions for baseballr

standings_dataset <- function(dates, division) {
  df <- tibble()

  for (i in dates) {
    bref_standings_on_date(date = i, division, from = F) %>%
      mutate(Date = i) -> data

    df <- bind_rows(df, data)
  }

  return(df)
}

batting_dataset <- function(date_list) {
  # The tsibble library is no longer needed here if yearmonth() is removed.
  df <- tibble()

  for (i in date_list) {
    # bref_daily_batter() already returns a 'Date' column.
    # The previous mutate(Date = yearmonth(i[2])) was causing an error because i[2] is NA
    # and was attempting to overwrite the existing 'Date' column.
    # This 'Date' column is removed later in the main script anyway.
    bref_daily_batter(t1 = i[1], t2 = i[2]) -> data
    df <- bind_rows(df, data)
  }
  return(df)
}
