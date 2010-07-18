require 'erb'
require 'rdiscount'
require 'cssmin'

module CV
  class HTML
    def initialize(cv)
      
      # Breaking down the data structure a little so I don't go insane
      
      @contact = cv['Personal Information']
      @skills = cv['Skills']
      @experience = cv['Experience']
      @education = cv['Education']
      
      return self
    end
    
    def html
      b = binding
      ERB.new(File.new('views/cv.html.erb','r').read).result(b)
    end
    
    def write(filename='cv.html')
      file = File.new(filename, 'w+')
      file.puts html
      file.close
    end
    
    private
    
    # Really just helper methods here to stop the template being a huge mess.
    
    def fullname
      return "#{@contact['First Name']} #{@contact['Last Name']}"
    end
    
    def contact_methods
      method_list = []
      method_list << ["Telephone", @contact['Home Phone']] if @contact['Home Phone']
      method_list << ["Mobile", @contact['Mobile Phone']] if @contact['Mobile Phone']
      method_list << ["Email", @contact['Email address']] if @contact['Email address']
      method_list << ["Web", @contact['Web site']] if @contact['Web site']
      
      if @contact['Address']
        address = []
        address << @contact['Address']['Street'] if @contact['Address']['Street']
        address << @contact['Address']['Town'] if @contact['Address']['Town']
        address << @contact['Address']['County'] if @contact['Address']['County']
        address << @contact['Address']['Post Code'] if @contact['Address']['Post Code']
        
        method_list << ["Address", address.join(', ')]
        
      end
      
      return method_list
            
    end
    
    def format_company(job)
      company = ""
      company << job['Company'] + ", "
      company << "#{job['Location']} , " if job['Location']
      if job['End Date']
        company << "#{job['Start Date']} - #{job['End Date']}\n"
      else
        company << "#{job['Start Date']}\n"
      end
      
      return company
      
    end
    
    def job_description(desc)
      Markdown.new(desc).to_html
    end
    
    def format_education(qualification)
      output = ""
      output << qualification['Organisation'] + ", "
      output << qualification['Location'] + ", "
      if qualification['Start Date']
        if qualification['End Date']
          output << "#{qualification['Start Date']} - #{qualification['End Date']}"
        else
          output << "#{qualification['Start Date']}"
        end
      end
      
      return output
    end
    
    def stylesheet
      CSSMin.minify(File.new('views/main.css','r').read)
    end
    
  end
end