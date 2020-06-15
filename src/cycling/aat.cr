require "xml"

class Cycling::AAT
  def self.import(file_name)
    file = File.read(file_name)
    a = XML.parse(file).children

    # Prepare Entries
    aat_arr = Array(Array(String)).new
    a.each { |s| s.children[3].children.each { |d| d.children.each do |f|
      ping = Array(String).new
      next if f.inner_text.chomp("\t").chomp.empty?
      f["lon"]?.nil? ? nil : ping << (f["lon"]?.to_s)
      f["lat"]?.nil? ? nil : ping << (f["lat"]?.to_s)
      f.children.each do |g|
        g.children.to_s.empty? ? nil : ping << g.children.to_s
      end
      ping.empty? ? nil : aat_arr << ping
    end } }
    puts aat_arr
  end

  def self.error
    puts "There was an error paring the file, please make sure your AAT gpx file is correct..."
    exit
  end
end
