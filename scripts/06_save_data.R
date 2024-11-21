source_path <- "/Users/y4nxunj/Downloads/hammer-2-processed.sqlite"
destination_path <- "/Users/y4nxunj/Downloads/grocery-price-analysis/data/hammer-2-processed.sqlite"

# Copy the file
if (file.copy(source_path, destination_path)) {
  message("File successfully copied to the data folder.")
} else {
  message("Failed to copy the file. Check paths and permissions.")
}
