module CV
  class PDF
    require 'prawn'
    require 'prawn/measurement_extensions'
    require "prawn/layout"
    
    def initialize(cv)
      contact = cv['Personal Information']
      skills = cv['Skills']
      experience = cv['Experience']
      education = cv['Education']
      
      @pdf = Prawn::Document.new(:page_layout => :portrait,
                           :left_margin => 15.mm,
                           :right_margin => 15.mm,
                           :top_margin => 15.mm,
                           :bottom_margin => 15.mm,
                           :page_size => 'A4')
      header! @pdf, contact
      contact_details! @pdf, contact  
      title! @pdf, "Skills"
      @pdf.text skills.first + "\n", :size => 9    
      skills_table! @pdf, skills
      
      return self
    end
    
    def write(filename='cv.pdf')
      @pdf.render_file(filename)
    end
    
    private
    
    def header!(pdf,contact)
      pdf.text "CV for #{contact['First Name']} #{contact['Last Name']}\n\n", :size => 14
      pdf.text "#{contact['Goal']}\n\n", :size => 9, :style => :italic if contact['Goal']
    end
    
    def contact_details!(pdf,contact)
      title! pdf, "Contact Details"
      pdf.font_size 9
      if contact['Address']
        address = "Address: "
        address << contact['Address']['Street'] + ", " if contact['Address']['Street']
        address << contact['Address']['Town'] + ", " if contact['Address']['Town']
        address << contact['Address']['County'] + ", " if contact['Address']['County']
        address << contact['Address']['Post Code'] if contact['Address']['Post Code']
        address << "\n"
        pdf.text address
      end
      
      pdf.text "Telephone: #{contact['Home Phone']}\n" if contact['Home Phone']
      pdf.text "Mobile: #{contact['Mobile Phone']}\n" if contact['Mobile Phone']
      pdf.text "Web: #{contact['Web site']}\n" if contact['Web site']
      pdf.text "Email: #{contact['Email address']}\n" if contact['Email address']
      pdf.text "\n" 
    end
    
    def title!(pdf,text)
      pdf.text text + "\n\n", :size => 10, :style => :bold
    end
    
    def skills_table!(pdf,skills)
      skills = skills[1..-1]
      skill_array = []
      skills.each do | skill |
        skill_array << [skill['Skill'],skill['Level']]
      end
      pdf.table skill_array, :font_size => 9
    end
    
  end
end
