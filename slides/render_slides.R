# slide render script
# created an appropriately dated version of the slides in this slide subdirectory

render_slides <- function(file_path, session_date){
  out_fn <- paste0("slides_",
                   tools::file_path_sans_ext(basename(file_path)),
                   ".html")
  
  site_fn <- paste0("docs/", 
                    stringr::str_extract(file_path, ".*\\/"),
                    out_fn)
  
  quarto::quarto_render(file_path,
                        output_format = "revealjs",
                        output_file = out_fn,
                        execute_params = list(sl_date = session_date),
                        metadata_file = "slides/slide_render.yml")
  
  file.copy(site_fn, paste0("slides/", out_fn), overwrite = T)
  unlink(site_fn)
}

# render_slides("skills/an_introduction_to_ai_and_why_you_might_avoid_that_term.qmd", "2025-09-24")

list.files("../", recursive = T, pattern = "*.qmd") |>
  stringr::str_subset(pattern = "applications") |>
  stringr::str_remove("KIND-training/") |>
  render_slides(session_date = "2025-09-24")


# listo <- list.files("../", recursive = T, pattern = "*.qmd")
# sessiono <- KINDR::training_sessions(output_type = "tibble")$URL[6]
# library(stringdist)
# listo[which(!is.na(stringdist::amatch(listo, sessiono, maxDist = 30)))]
