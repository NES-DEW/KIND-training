#' Get a feedback URL from a session title and date
#'
#' @param session A session title
#' @param date A string in YYYY-MM-DD format
#'
#' @return a feedback url
#' @export
#'
#' @examples feedback_url("KIND one-off training session: why bother with…Power BI?", "2024-06-13")
feedback_url <- function(session, date){
  glue::glue("https://forms.office.com/Pages/ResponsePage.aspx?id=veDvEDCgykuAnLXmdF5Jmn79kl25VpJIq3eErXXCYKBUMlhWQVRTMERFVjU5TUdMSEVEMzYwODRWVC4u&r763e4a3a535149438ffa4d7812e07773={URLencode(session)}&r96bb56f248fb457899d2a813d349450f=%22{date}%22")
}


