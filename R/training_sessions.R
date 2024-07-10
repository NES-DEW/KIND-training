source(here::here("R/nice_date.R"))
source(here::here("R/KIND_ics_maker.R"))

training_sessions <- function(tr_type = "all", start_date = "today", end_date = lubridate::dmy("01-12-2025"), dt_output = FALSE){
  
  sesh <- readr::read_csv("data/KIND_training_sessions.csv")
  
  schedule <- readr::read_csv("data/training_schedule.csv")
  if (paste(tr_type, collapse = " ") != "all") {
    
    poss_sesh <- sesh |>
      dplyr::filter(`Platform / area` %in% tr_type) |>
      pull(Title)
    
    schedule <- schedule |>
      dplyr::filter(`session title` %in% poss_sesh)
  }
  
  if (start_date == "today") {
    schedule <- schedule |>
      dplyr::filter(start > lubridate::today() + lubridate::days(1)) |>
      dplyr::filter(start < end_date)
  } else {
    schedule <- schedule |>
      dplyr::filter(start > lubridate::ymd(start_date)) |>
      dplyr::filter(start < lubridate::ymd(end_date))
  }
  
  out <- schedule |>
    dplyr::left_join(sesh, by = dplyr::join_by(`session title` == Title)) |>
    dplyr::rowwise() |>
    dplyr::mutate(linky = paste0("<a href='", url, "'>", `session title`, "</a>")) |>
    dplyr::mutate(Level = factor(Level, levels = c("pre-beginner", "beginner", "intermediate", "advanced", "managerial"))) |>
    dplyr::mutate(desc2 = dplyr::case_when(
      stringr::str_detect(Level, "pre-beginner") ~ "🥬: <b>pre-beginner-level</b>",
      stringr::str_detect(Level, "beginner") ~ paste0("<style='color:red'>", "🌶", "</style> :<b>beginner-level</b>"),
      stringr::str_detect(Level, "inter") ~ paste0("<style='color:red'>", "🌶🌶", "</style>: <b>intermediate-level</b>"),
      stringr::str_detect(Level, "advanced") ~ paste0("<style='color:red'>", "🌶🌶🌶", "</style>: <b>advanced-level</b>"),
      stringr::str_detect(Level, "manag") ~ "💼: <b>non-technical</b>")) |>
    dplyr::mutate(end = start + lubridate::minutes(`Duration (minutes)`)) |>
    dplyr::mutate(ics_link = purrr::pmap(dplyr::across(dplyr::everything()), ~ KIND_ics_maker(title_arg = `session title`, desc_string = paste(Description), start = start, end = end, link = url))) |>
    dplyr::mutate(friendly_date = paste0(
      format(start, "%H:%M"),
      "-",
      nice_date(end))) |>
    dplyr::select(Session = linky, Date = friendly_date, Level2 = Level, Area = `Platform / area`, Level = desc2, start, `Calendar invite` = ics_link) |>
    dplyr::arrange(start, Level2) |>
    dplyr::select(!c(Level2, start)) |>
    dplyr::ungroup()
    
  
  if(dt_output){
    out |>
      DT::datatable(escape = FALSE,
                    filter = "top")
  } else {
    out |>
      kableExtra::kbl(escape = FALSE)
  }

}
# training_sessions()
