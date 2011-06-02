require './lib/helpers'

module CV
  class PlainText
    # This is the parser to output plain text files.

    def initialize(cv)
      contact = cv['Personal Information']
      skills = cv['Skills']
      experience = cv['Experience']
      education = cv['Education']

      @plaintext = header(contact)
      @plaintext << contact_details(contact)
      
      @plaintext << skills_header(skills)
      @plaintext << skill_table(skills)
      
      @plaintext << work_history(experience)
      
      @plaintext << education(education)

      return self

    end
    
    def puts
      puts @plaintext
    end
    
    def text
      @plaintext
    end

    def write(filename='cv.txt')
      file = File.new(filename, 'w+')
      file.puts @plaintext
      file.close
    end

    private

    def title(text)

      output = text + "\n" 
      text.length.times { output << "-" } 
      output << "\n\n"

    end

    def contact_details(contact)

      output = title "Contact Details"
      if contact['Address']
        output << "Address:\n"
        output << contact['Address']['Street'].indent(11) + "\n" if contact['Address']['Street']
        output << contact['Address']['Town'].indent(11) + "\n" if contact['Address']['Town']
        output << contact['Address']['County'].indent(11) + "\n" if contact['Address']['County']
        output << contact['Address']['Post Code'].indent(11) + "\n" if contact['Address']['Post Code']
        output << "\n"
      end
      
      output << "Telephone: #{contact['Home Phone']}\n" if contact['Home Phone']
      output << "   Mobile: #{contact['Mobile Phone']}\n" if contact['Mobile Phone']
      output << "      Web: #{contact['Web site']}\n" if contact['Web site']
      output << "    Email: #{contact['Email address']}\n" if contact['Email address']
      output << "\n"
      
      return output

    end

    def header(contact)

      output = title "CV for #{contact['First Name']} #{contact['Last Name']}"
      output << contact['Goal'] + "\n\n" if contact['Goal']

      return output

    end
    
    def skills_header(skills)
      
      output = title("Skills")
      output << skills.first + "\n"
      
    end

    def skill_table(skills)
      
      skills = skills[1..-1]

      max_skill_length = skills.map { | skill | skill['Skill'].length}.max
      max_level_length = skills.map { | skill | skill['Level'].length}.max

      output = "+-" + "Skill".center(max_skill_length,"-") + "-+-" + "Level".center(max_level_length,"-") + "-+\n"

      skills.each do | skill |
        output << "| " + skill['Skill'].ljust(max_skill_length)
        output << " | "
        output << skill['Level'].ljust(max_level_length) + " |\n"
      end

      output << "+-"
      max_skill_length.times { output << "-" }
      output << "-+-"
      max_level_length.times {output << "-"}
      output << "-+\n\n"

    end
    
    def work_history(exp)
      
      output = title("Experience")
      exp.each do | job |
        output << job['Company'] + "\n"
        output << "#{job['Location']} | " if job['Location']
        if job['End Date']
          output << "#{job['Start Date']} - #{job['End Date']}\n"
        else
          output << "#{job['Start Date']}\n"
        end
        output << job['Job Title'] + "\n\n"
        output << job['Description'] + "\n"
      end
      
      return output
      
    end
    
    def education(edu)
      
      output = title("Education")
      edu.each do | qual |
        output << qual['Organisation'] + "\n"
        output << qual['Location']
        if qual['Start Date']
          if qual['End Date']
            output << " | #{qual['Start Date']} - #{qual['End Date']}\n"
          else
            output << " | #{qual['Start Date']}\n"
          end
        else
          output << "\n"
        end
        output << qual['Results'] + "\n"
      end
      
      return output
    end

  end

end