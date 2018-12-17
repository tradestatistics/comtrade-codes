# Open ts-comtrade-codes.Rproj before running this script

# Copyright (c) 2018, Mauricio \"Pacha\" Vargas
# This file is part of Open Trade Statistics project
# The scripts within this project are released under GNU General Public License 3.0
# See https://github.com/tradestatistics/ts-yearly-datasets/LICENSE for the details

#1: Tidy country codes

if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr, readxl, janitor, countrycode)

raw_country_dir <- "01-1-raw-country-data"
tidy_country_dir <- "01-2-tidy-country-data"
try(dir.create(tidy_country_dir))

country_codes <- read_excel(paste0(raw_country_dir, "/country-codes.xls")) %>% 
  clean_names() %>% 
  filter(iso3_digit_alpha != "NULL")

continents <- countrycode::codelist %>% 
  as_tibble() %>% 
  select(iso3c, continent, eu28) %>% 
  filter(!is.na(iso3c))

continents2 <- continents %>% 
  select(continent) %>% 
  filter(!is.na(continent)) %>% 
  distinct() %>% 
  mutate(continent_id = row_number())

continents3 <- continents %>% 
  select(iso3c, continent) %>% 
  filter(
    !is.na(iso3c),
    !is.na(continent)
  ) %>%
  left_join(continents2) %>% 
  left_join(continents %>% select(iso3c, eu28)) %>% 
  rename(eu28_member = eu28) %>% 
  mutate(
    iso3c = ifelse(iso3c == "ROU", "ROM", iso3c),
    eu28_member = ifelse(iso3c == "ROM", 1, eu28_member)
  ) %>% 
  select(iso3c, continent_id, continent, eu28_member)

country_codes <- country_codes %>% 
  left_join(continents3 %>% select(iso3c, continent_id), by = c("iso3_digit_alpha" = "iso3c")) %>% 
  filter(
    !country_code %in% 
      c(
        0,
        10,
        58,
        97,
        230,
        280,
        356,
        532,
        588,
        590,
        658,
        711,
        841,
        868,
        886
      )
  ) %>% 
  mutate(
    continent_id = ifelse(iso3_digit_alpha == "DDR", 2, continent_id),
    continent_id = ifelse(iso3_digit_alpha %in% 
                            c("IOT","VDR","YMD","TMP"), 1, continent_id),
    continent_id = ifelse(iso3_digit_alpha %in% 
                            c("CSK","DDR","SUN","YUG","ROM","SCG"), 2, continent_id),
    continent_id = ifelse(iso3_digit_alpha %in% 
                            c("ATF"), 3, continent_id),
    continent_id = ifelse(iso3_digit_alpha %in% 
                            c("PCI","HMD"), 4, continent_id),
    continent_id = ifelse(iso3_digit_alpha %in% 
                            c("ARB","PCZ","CCK","SGS","UMI","BVT","ANT"), 5, continent_id)
  ) %>% 
  left_join(continents2 %>% select(continent_id, continent), by = "continent_id") %>% 
  left_join(continents3 %>% select(iso3c, eu28_member), by = c("iso3_digit_alpha" = "iso3c")) %>% 
  mutate(eu28_member = ifelse(is.na(eu28_member), 0, 1))

country_codes_2 <- country_codes %>% 
  filter(country_code %in% c(56,251,276,699,528,659,586,591,842,887,710)) %>% 
  mutate(
    country_fullname_english = c(
      "Belgium (Belgium-Luxembourg Customs Union until 1999)",
      "France (includes Monaco)",
      "Germany (former Federal Republic of Germany until 1990)",
      "India (excludes Sikkim until 1975)",
      "Netherlands Antilles (includes Aruba until 1988)",
      "Pakistan (former East and West Pakistan until 1962)",
      "Panama (excludes Panama Canal Zone until 1978)",
      "Saint Kitts and Nevis (includes Anguilla until 1981)",
      "South Africa (Southern African Customs Union until 2000)",
      "USA, Puerto Rico and US Virgin Islands (excludes Virgin Islands until 1981)",
      "Yemen (former Arab Republic of Yemen until 1991)"
    )
  )

country_codes <- country_codes %>% 
  anti_join(country_codes_2, by = "country_code") %>% 
  bind_rows(country_codes_2)

save(country_codes, file = paste0(tidy_country_dir, "/country-codes.RData"), compress = "xz")

#2: Tidy product codes

raw_product_dir <- "02-1-raw-product-data"
tidy_product_dir <- "02-2-tidy-product-data"
try(dir.create(tidy_product_dir))

product_codes <- read_excel(paste0(raw_product_dir, "/official-list-of-comtrade-codes.xlsx")) %>% 
  clean_names()

save(product_codes, file = paste0(tidy_product_dir, "/product-codes.RData"), compress = "xz")

product_correlation <- read_excel(paste0(raw_product_dir, "/official-correlations-between-comtrade-codes.xlsx")) %>% 
  clean_names()

save(product_correlation, file = paste0(tidy_product_dir, "/product-correlation.RData"), compress = "xz")

hs2007_to_sitc1 <- read_excel("02-1-raw-product-data/hs2007-to-sitc1.xls", sheet = "Conversion Table", range = "A1:B5046") %>% 
  rename(hs07 = From, sitc1 = To) %>% 
  filter(row_number() > 1)

hs2007_to_sitc2 <- read_excel("02-1-raw-product-data/hs2007-to-sitc2.xls", sheet = "Conversion Table", range = "B1:C5052") %>% 
  rename(hs07 = From, sitc2 = To) %>% 
  filter(row_number() > 1)

hs2007_to_hs1992 <- read_excel("02-1-raw-product-data/hs2007-to-hs1992.xls",  sheet = "Conversion Tables", range = "A1:B5054") %>% 
  rename(hs07 = From, hs92 = To) %>% 
  filter(row_number() > 1)

hs2007_to_hs1996 <- read_excel("02-1-raw-product-data/hs2007-to-hs1996.xls", sheet = "Conversion Tables", range = "A1:B5054") %>% 
  rename(hs07 = From, hs96 = To) %>% 
  filter(row_number() > 1)

hs2007_to_hs2002 <- read_excel("02-1-raw-product-data/hs2007-to-hs2002.xls", sheet = "Conversion Tables", range = "A1:B5054") %>% 
  rename(hs07 = From, hs02 = To) %>% 
  filter(row_number() > 1)

product_conversion <- hs2007_to_hs1992 %>% 
  full_join(hs2007_to_hs1996) %>% 
  full_join(hs2007_to_hs2002) %>% 
  full_join(hs2007_to_sitc1) %>% 
  full_join(hs2007_to_sitc2)

save(product_conversion, file = paste0(tidy_product_dir, "/product-conversion.RData"), compress = "xz")
