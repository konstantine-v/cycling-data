require "xml"

class Cycling::AAT
  def self.import(file)
    f = File.read(file)
    d = XML.parse(f).children

    # Get Time
    d.each do |q|
      puts q.children[1].inner_text
    end

    # Get Entries
    d.each{|q| q.children[3].children.each{|f| f.children.each do |g|
                                             puts g # Get attributes for lat and lon
                                             g.children.each{|h| puts h.children} # Printing for testing purposes
                                             # TODO: Format the data to nested array or some other type to access
                                           end}}
  end
  def self.error
    puts "There was an error paring the file, please make sure your AAT gpx file is correct..."
    exit
  end
end
