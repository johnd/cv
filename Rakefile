# Rake tasks for generating CV files from a YAML file.
# All filenames default to 'cv.ext' for convenience.
module CV
  FORMATS = [:plaintext, :PDF, :HTML]
  require 'yaml'
  require "rubygems"
  require "bundler"
  Bundler.setup

  task :default => "CV:all"

  namespace :CV do

    desc "Parse CV into all available formats"
    task :all => FORMATS

    desc "Parse CV into plain text"
    task :plaintext do
      require './lib/plain_text'
      require 'yaml'
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

    desc "Parse CV into HTML"
    task :HTML do
      require './lib/html'
      input = ENV['infile'] || "cv.yml"
      if ENV['outfile']
        output = ENV['outfile'].gsub(/\.[^.]+$/,'') + ".html"
      else
        output = "cv.html"
      end
      cv = YAML.load_file(input)
      HTML.new(cv).write(output)
      puts "HTML CV written to #{output}."
    end

    desc "Parse CV into PDF"
    task :PDF do
      require './lib/html' # Confused? Using PDFKit means the HTML generator does the hard work.
      require 'pdfkit'
      input = ENV['infile'] || "cv.yml"
      if ENV['outfile']
        output = ENV['outfile'].gsub(/\.[^.]+$/,'') + ".pdf"
      else
        output = "cv.pdf"
      end

      cv = YAML.load_file(input)
      PDFKit.new(HTML.new(cv).html, :page_size => 'A4').to_file(output)
      puts "PDF CV written to #{output}."
    end

  end

end
