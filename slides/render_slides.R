# slide render script
# created an appropriately dated version of the slides in this slide subdirectory

render_slides <- function(file_path, session_date){
  # fn <- "excel/references_and_names_in_excel.qmd" # path relative to project wd
  session_date <- "2025-09-17" #in this format, don't fool with it
  
  out_fn <- paste0("slides_",
                   tools::file_path_sans_ext(basename(file_path)),
                   ".html")
  
  site_fn <- paste0("_site/", 
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

render_slides("excel/references_and_names_in_excel.qmd", "2025-09-17")