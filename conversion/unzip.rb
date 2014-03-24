require 'rubygems'
require 'zip'

# All of this assumes you're running from the same directory as the zip files.

## Pass in the file name, no extention.
def unpack_to_folder(name)
  Zip::File.open("#{name}.zip") do |zip_file|
    zip_file.each do |entry|
      puts "Extracting #{entry.name}"
      
      Dir.mkdir 'aipStore' unless File.exists? "aipStore"

      # Dumps zip contents to files.
      entry.extract("aipStore/#{entry.name}")

      # Read into memory if necessary
      # content = entry.get_input_stream.read
    end
  end
end

