# Open ts-comtrade-codes.Rproj before running this script

#1: Tidy country codes

if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr, readxl, janitor)

raw_country_dir <- "01-1-raw-country-data"
tidy_country_dir <- "01-2-tidy-country-data"
try(dir.create(tidy_country_dir))

country_codes <- read_excel(paste0(raw_country_dir, "/country-codes.xls")) %>% 
  clean_names()

save(country_codes, file = paste0(tidy_country_dir, "/country-codes.RData"), compress = "xz")

#2: Tidy product codes

raw_product_dir <- "02-1-raw-product-data"
tidy_product_dir <- "02-2-tidy-product-data"
try(dir.create(tidy_product_dir))

product_codes <- read_excel(paste0(raw_product_dir, "/official-list-of-comtrade-codes.xlsx")) %>% 
  clean_names()

save(product_codes, file = paste0(tidy_product_dir, "/product-codes.RData"), compress = "xz")

product_correspondence <- read_excel(paste0(raw_product_dir, "/official-correspondence-between-comtrade-codes.xlsx")) %>% 
  clean_names()

save(product_correspondence, file = paste0(tidy_product_dir, "/product-correspondence.RData"), compress = "xz")
