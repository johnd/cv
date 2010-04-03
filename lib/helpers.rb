class String
  def indent(n)
    # Makes text formatting easier.
    
    if n >= 0
      gsub(/^/, ' ' * n)
    else
      gsub(/^ {0,#{-n}}/, "")
    end
  end
end
