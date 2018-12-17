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
  clean_names()

continents <- countrycode::codelist %>% 
  as_tibble() %>% 
  select(iso3c, continent, eu28)

continents2 <- continents %>% 
  select(continent) %>% 
  filter(!is.na(continent)) %>% 
  distinct() %>% 
  mutate(continent_id = row_number())

continents <- continents %>% 
  left_join(continents2) %>% 
  rename(eu28_member = eu28) %>% 
  mutate(eu28_member = ifelse(is.na(eu28_member), 0, 1)) %>% 
  select(iso3c, continent_id, continent, eu28_member)

country_codes <- country_codes %>% 
  left_join(continents, by = c("iso3_digit_alpha" = "iso3c"))

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
