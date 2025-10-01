# slide render script
# created an appropriately dated version of the slides in this slide subdirectory

render_slides <- function(file_path, session_date){
  out_fn <- paste0(tools::file_path_sans_ext(basename(file_path)),
                   "_",
                   as.character(session_date), 
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

render_slides("excel/excel_tables.qmd", "2025-10-01")
