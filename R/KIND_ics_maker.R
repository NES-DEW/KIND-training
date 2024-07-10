KIND_ics_maker <- function(title_arg, desc_string, link, start, end){
  
  path <- paste0("www/", snakecase::to_snake_case(title_arg), ".ics")
  
  if(!file.exists(path)){
    start_time <- lubridate::parse_date_time(start, orders="ymd_HMS", tz = "Europe/London") |>
      lubridate::with_tz("UTC") |>
      format("%Y%m%dT%H%M%SZ") 
    
    end_time <- lubridate::parse_date_time(end, orders="ymd_HMS", tz = "Europe/London") |>
      lubridate::with_tz("UTC") |>
      format("%Y%m%dT%H%M%SZ") 
    
    desc <- c(paste(paste0("DESCRIPTION:", desc_string, "\\n \\n"), 
                    "All welcome - please follow this link to join the session:",
                    paste0("<", link, ">")), 
              paste0("SUMMARY:", title_arg))
    
    head <- c("BEGIN:VCALENDAR",
              "CALSCALE:GREGORIAN",
              "PRODID:-//Microsoft Corporation//Outlook 16.0 MIMEDIR//EN",
              "VERSION:2.0",
              "METHOD:PUBLISH",
              "X-WR-CALNAME:atf-test",
              "BEGIN:VEVENT")
    
    times <- c(paste0("DTSTART:", start_time),
               paste0("DTEND:", end_time),
               "DTSTAMP:20240709T125800Z",
               paste0("UID:KIND", start_time, "@nhs.scot"))
    
    end <- c("LOCATION:KIND Learning Network Teams channel",
             "SEQUENCE:0",
             "STATUS:CONFIRMED",
             "TRANSP:OPAQUE",
             "END:VEVENT",
             "END:VCALENDAR")
    
    c(head, times, desc, end) |>
      readr::write_lines(path)
  }
  
  
  
  glue::glue("<a href='{path}'>📅 .ics</a>")
} 

# KIND_ics_maker("KIND one-off training session: Excel formatting", "🌶 an introductory session on Excel formatting. \\n You'll need some variety of Excel, and basic familiarity with it.", "https://teams.microsoft.com/l/meetup-join/19%3ab03b2fd777e440eaa255ba67569762b5%40thread.tacv2/1720012218893?context=%7b%22Tid%22%3a%2210efe0bd-a030-4bca-809c-b5e6745e499a%22%2c%22Oid%22%3a%225d92fd7e-56b9-4892-ab77-84ad75c260a0%22%7d", "2024-07-10 15:00:00", "2024-07-10 16:00:00")
