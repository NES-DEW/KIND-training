nice_date <- function(date){
if(lubridate::is.Date(date)) {
  paste(lubridate::wday(date, label = T),
        scales::ordinal(lubridate::day(date)),
        lubridate::month(date, label = T, abbr = F),
        lubridate::year(date))
} else if(lubridate::is.POSIXct(date)) {
  paste(format(date, "%H:%M"),
        lubridate::wday(date, label = T),
        scales::ordinal(lubridate::day(date)),
        lubridate::month(date, label = T, abbr = F),
        lubridate::year(date))
} else {
  "Dunno what to do with that"
}

}
