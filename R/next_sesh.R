
next_sesh <- function(page_title){
  
  forthcoming <- readr::read_csv(here::here("data/training_schedule.csv")) |>
    dplyr::filter(`session title` == page_title, start >= lubridate::now()) 
  
  
  if(nrow(forthcoming) > 0){
    
    cat("  \n")
    
    cat("::: {.callout-tip collapse=false appearance='default' icon=true}  \n")
    
    cat("## Forthcoming session(s)  \n")
    
    KINDR::training_sessions(output_type = "tibble") |>
      dplyr::filter(title %in% forthcoming$`session title`,
                    start >= min(forthcoming$start)) |>
      dplyr::mutate(title = paste0("<a href='", url, "'>", title, "</a>")) |>
      dplyr::select(`Booking link` = title, Date = friendly_date) |>
      kableExtra::kbl(escape = FALSE) |>
      cat()
    
    cat("  \n")
    
    cat(":::  \n")

  }

}
# next_sesh("Pivot tables and pivot charts (intermediate Excel session 4)")

# :::{.callout-tip collapse=false appearance='default' icon=true}

## Forthcoming sessions(s)
# :::