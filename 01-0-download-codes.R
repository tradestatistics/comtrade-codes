# Open ts-comtrade-codes.Rproj before running this script

# Copyright (c) 2018, Mauricio \"Pacha\" Vargas
# This file is part of Open Trade Statistics project
# The scripts within this project are released under GNU General Public License 3.0
# See https://github.com/tradestatistics/ts-yearly-datasets/LICENSE for the details

#1: Import country codes

raw_country_dir <- "01-1-raw-country-data"
try(dir.create(raw_country_dir))

url <- c(
  "https://comtrade.un.org/data/cache/reporterAreas.json",
  "http://unstats.un.org/unsd/tradekb/Attachment321.aspx?AttachmentType=1"
)

file <- paste0(raw_country_dir, 
                c(
                  "/country-codes.json",
                  "/country-codes.xls"
                  )
)

lapply(seq_along(url), function (t) if (!file.exists(file[t])) { download.file(url[t], file[t]) })

#2: Import product codes

raw_product_dir <- "02-1-raw-product-data"
try(dir.create(raw_product_dir))

url <- c(
  "https://unstats.un.org/unsd/tradekb/Attachment439.aspx?AttachmentType=1",
  "https://unstats.un.org/unsd/trade/classifications/tables/CompleteCorrelationsOfHS-SITC-BEC_20170606.xlsx",
  "https://unstats.un.org/unsd/trade/classifications/tables/HS%202007%20to%20SITC%20Rev%201%20Correlation%20and%20conversion%20tables.xls",
  "https://unstats.un.org/unsd/trade/classifications/tables/HS%202007%20to%20SITC%20Rev%202%20Correlation%20and%20conversion%20tables.xls",
  "https://unstats.un.org/unsd/trade/classifications/tables/HS%202007%20to%20HS%201992%20Correlation%20and%20conversion%20tables.xls",
  "https://unstats.un.org/unsd/trade/classifications/tables/HS%202007%20to%20HS%201996%20Correlation%20and%20conversion%20tables.xls",
  "https://unstats.un.org/unsd/trade/classifications/tables/HS%202007%20to%20HS%202002%20Correlation%20and%20conversion%20tables.xls"
)
  
file <- paste0(raw_product_dir, 
               c(
                 "/official-list-of-comtrade-codes.xlsx",
                 "/official-correlations-between-comtrade-codes.xlsx",
                 "/hs2007-to-sitc1.xls",
                 "/hs2007-to-sitc2.xls",
                 "/hs2007-to-hs1992.xls",
                 "/hs2007-to-hs1996.xls",
                 "/hs2007-to-hs2002.xls"
                )
)

lapply(seq_along(url), function (t) if (!file.exists(file[t])) { download.file(url[t], file[t]) })
