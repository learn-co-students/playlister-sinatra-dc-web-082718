class Slugifiable


  def self.slug(str)
    str = str.downcase.split.join("-")
    str
  end
  
end
