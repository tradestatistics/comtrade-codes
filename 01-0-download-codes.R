# Open ts-comtrade-codes.Rproj before running this script

#1: Import country codes

raw_country_dir <- "01-1-raw-country-data"
try(dir.create(raw_country_dir))

url <- "https://comtrade.un.org/data/cache/reporterAreas.json"
json <- paste0(raw_country_dir, "/country-codes.json")
if (!file.exists(json)) {
  download.file(url, json, method = "wget")
}

url <- "http://unstats.un.org/unsd/tradekb/Attachment321.aspx?AttachmentType=1"
xls <- paste0(raw_country_dir, "/country-codes.xls")
if (!file.exists(xls)) {
  download.file(url, xls, method = "wget")
}

#2: Import product codes

raw_product_dir <- "02-1-raw-product-data"
try(dir.create(raw_product_dir))

url <- "https://unstats.un.org/unsd/tradekb/Attachment439.aspx?AttachmentType=1"
xlsx <- paste0(raw_product_dir, "/official-list-of-comtrade-codes.xlsx")

if (!file.exists(xlsx)) {
  download.file(url, xlsx)
}

url <- "https://unstats.un.org/unsd/trade/classifications/tables/CompleteCorrelationsOfHS-SITC-BEC_20170606.xlsx"
xlsx <- paste0(raw_product_dir, "/official-correspondence-between-comtrade-codes.xlsx")

if (!file.exists(xlsx)) {
  download.file(url, xlsx)
}
