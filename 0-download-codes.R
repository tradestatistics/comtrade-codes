# Open oec-comtrade-codes.Rproj before running this script

#1: Import country codes

url <- "https://comtrade.un.org/data/cache/reporterAreas.json"
json <- "country-codes.json"
if (!file.exists(json)) {
  download.file(url, json, method = "wget")
}

url <- "http://unstats.un.org/unsd/tradekb/Attachment321.aspx?AttachmentType=1"
xls <- "country-codes.xls"
if (!file.exists(xls)) {
  download.file(url, xls, method = "wget")
}

#2: Import product codes

url <- "https://unstats.un.org/unsd/tradekb/Attachment439.aspx?AttachmentType=1"
xlsx <- "official-list-of-comtrade-codes.xlsx"

if (!file.exists(xlsx)) {
  download.file(url, xlsx)
}

url <- "https://unstats.un.org/unsd/trade/classifications/tables/CompleteCorrelationsOfHS-SITC-BEC_20170606.xlsx"
xlsx <- "official-correspondence-between-comtrade-codes.xlsx"

if (!file.exists(xlsx)) {
  download.file(url, xlsx)
}
