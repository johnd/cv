# Rake tasks for generating CV files from a YAML file.
# All filenames default to 'cv.ext' for convenience.
module CV
  FORMATS = [:plaintext]
  
  task :default => "CV:all"

  namespace :CV do
    
    desc "Parse CV into all available formats"
    task :all => FORMATS
    
    desc "Parse CV into plain text"
    task :plaintext do
      require 'lib/plain_text'
      input = ENV['infile'] || "cv.yml"
      if ENV['outfile']
        output = ENV['outfile'].gsub(/\.[^.]+$/,'') + ".txt"
      else
        output = "cv.txt"
      end

      cv = YAML.load_file(input)
      PlainText.new(cv).write(output)
      puts "Plain text CV written to #{output}."

    end

  end

end