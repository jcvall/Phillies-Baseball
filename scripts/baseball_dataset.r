# Dataset for Tablaeu

## Libraries ----
library(baseballr)
library(tidyverse)
library(gghighlight)
library(janitor)
library(here)
library(lubridate)
library(naniar)
library(dlookr)


## function ----
source(here('test', 'data_pull.r'))

## data tables ----

base <- standings_dataset(
  dates = c(
    '2022-04-30',
    '2022-05-31',
    '2022-06-30',
    '2022-07-31',
    '2022-08-31',
    '2022-09-30',
    '2022-10-31',
    '2023-04-30',
    '2023-05-31',
    '2023-06-30',
    '2023-07-31',
    '2023-08-31',
    '2023-09-30',
    '2023-10-31',
    '2024-04-30',
    '2024-05-31',
    '2024-06-30',
    '2024-07-31',
    '2024-08-31',
    '2024-09-30',
    '2024-10-31',
    '2025-04-30',
    '2025-05-31'
  ),
  division = 'NL East'
)

batting <- batting_dataset(
  date_list = c(
    '2022-04-30',
    '2022-05-31',
    '2022-06-30',
    '2022-07-31',
    '2022-08-31',
    '2022-09-30',
    '2022-10-31',
    '2023-04-30',
    '2023-05-31',
    '2023-06-30',
    '2023-07-31',
    '2023-08-31',
    '2023-09-30',
    '2023-10-31',
    '2024-04-30',
    '2024-05-31',
    '2024-06-30',
    '2024-07-31',
    '2024-08-31',
    '2024-09-30',
    '2024-10-31',
    '2025-04-30',
    '2025-05-31'
  )
)

#### Removing players with no at bats
batting <- batting %>% filter(AB > 0)

## EDA ----

gg_miss_var(base)
gg_miss_var(batting)

eda_web_report(base, target = "W")

eda_web_report(batting, target = "OPS")


## Chart Analysis

### Win Analysis for NL-East
base %>%
  rename('Month' = Date, 'Wins' = W) %>%
  mutate(Month = as.Date(Month)) %>%
  ggplot(aes(y = Wins, x = Month, color = Tm)) +
  geom_line() +
  geom_smooth() +
  gghighlight(max(Wins) > 80) +
  labs(
    title = "Philies ended strong, but not able to overtake the Braves",
    subtitle = "strong midseason propels philadelpha to 2nd place in NL East, but ended up winning the NL-East in Post Season.",
    caption = "baseballR package",
    x = ""
  ) +
  theme_classic()

base %>%
  group_by(Tm) %>%
  summarise(Wins = max(W))

## File

write_csv(base, here('reports', 'standings_data.csv'))

write_csv(batting, here('reports', 'batting_Stats.csv'))
