# slide render script
# created an appropriately dated version of the slides in this slide subdirectory

render_slides <- function(file_path, session_date){
  out_fn <- paste0("slides_",
                   tools::file_path_sans_ext(basename(file_path)),
                   "_",
                   as.character(session_date), 
                   ".html")
  
  site_fn <- paste0("_site/", stringr::str_extract(file_path, ".*\\/"), out_fn)
  
  quarto::quarto_render(file_path,
                        output_format = "revealjs",
                        output_file = out_fn,
                        execute_params = list(sl_date = session_date),
                        metadata_file = "slides/slide_render.yml")
  
  file.copy(site_fn, paste0("slides/", out_fn), overwrite = T)
  
  unlink(site_fn)
}

render_slides("excel/excel_first_steps.qmd", "2026-04-29")
render_slides("excel/tidy_data_in_excel.qmd", "2026-05-06")
render_slides("excel/references_and_names_in_excel.qmd", "2026-05-13")
render_slides("excel/excel_formatting.qmd", "2026-05-20")
render_slides("excel/excel_tables.qmd", "2026-05-27")
render_slides("excel/excel_formulas.qmd", "2026-06-03")
render_slides("excel/excel_practical_review.qmd", "2026-06-10")
# render_slides("excel/excel_practical_review.qmd", "2026-02-24")
# render_slides("skills/ebm_01.qmd", "2026-04-29")



