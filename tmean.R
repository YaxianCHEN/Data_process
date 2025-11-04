rootdir <- "C:/Users/qq958/Downloads/wc2.1_cruts4.06_10m_1960-1969"

outputdir <- file.path(rootdir, "Tmean_monthly")
if (!dir.exists(outputdir)) {
  dir.create(outputdir, recursive = TRUE)
}

for (year in 2010:2019) {     
  for (month in 1:12) {
    tmax_filename <- sprintf("wc2.1_2.5m_tmax_%04d-%02d.tif", year, month)
    tmin_filename <- sprintf("wc2.1_2.5m_tmin_%04d-%02d.tif", year, month)
    
    fullpathtmax <- file.path(rootdir, "wc2.1_cruts4.06_2.5m_tmax_2010-2019",  tmax_filename)       
    fullpathtmin <- file.path(rootdir, "wc2.1_cruts4.06_2.5m_tmin_2010-2019",  tmin_filename)
    
    if (file.exists(fullpathtmax) && file.exists(fullpathtmin)) {
      tmax_raster <- raster(fullpathtmax)
      tmin_raster <- raster(fullpathtmin)
      tmean_raster <- (tmax_raster + tmin_raster) / 2
      outputfile <- file.path(outputdir, sprintf("Tmean_%04d-%02d.tif", year, month))
      writeRaster(tmean_raster, filename = outputfile, format = "GTiff", overwrite = TRUE)
      
      cat(paste("Monthly mean temperature for", year, month, "saved to", outputfile, "\n"))
    } 
  }
}

cat("All monthly mean temperature calculations completed!\n")
