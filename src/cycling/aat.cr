require "xml"

class Cycling::AAT

  # Get distance of coordinates in kilometers
  def self.distance(loc1, loc2)
    rad_per_deg = Math::PI/180  # PI / 180
    rm = 6371000                  # Earth radius in kilometers

    dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
    dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg

    lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
    lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }

    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))

    rm * c # Return distance in meters
  end

  def self.import(file_name)
    file = File.read(file_name)
    a = XML.parse(file).children

    # Prepare Entries
    aat_arr = Array(Array(String|Float64)).new
    a.each { |s| s.children[3].children.each { |d| d.children.each do |f|
      ping = Array(String|Float64).new
      next if f.inner_text.chomp("\t").chomp.empty?
      f["lon"]?.nil? ? nil : ping << (f["lon"]?.to_s.to_f64)
      f["lat"]?.nil? ? nil : ping << (f["lat"]?.to_s.to_f64)
      f.children.each do |g|
        g.children.to_s.empty? ? nil : ping << g.children.to_s
      end
      ping.empty? ? nil : aat_arr << ping
    end } }

    dist_arr = Array(Float64|Int64).new
    (0..(aat_arr.size-1)).each do |m|
      if m != aat_arr.size-1
        dist_arr << Cycling::AAT.distance([aat_arr[m][0].to_f64, aat_arr[m][1].to_f64],[aat_arr[m+1][0].to_f64, aat_arr[m+1][1].to_f64])
      else
      end
    end

    fin_date = aat_arr[0][-1].to_s.gsub(/T.*/im,"").gsub('-',"")
    fin_dist = dist_arr.sum.to_i
    # TODO: Calculate avg speed
    # puts (aat_arr[0][-1].to_s.gsub(/.*T/im,"").gsub(".000Z","").to_i)
    # ( aat_arr[-1][-1].to_s.gsub(/T.*/im,"").gsub('-',""))

    ENV["file"] ||= "./data.csv"
    File.exists?(ENV["file"]) ? true : Cycling.create_file
    Cycling.build_file(fin_date, fin_dist, nil, nil, nil, nil, nil, nil)
  end

  def self.error
    puts "There was an error paring the file, please make sure your AAT gpx file is correct..."
    exit
  end
end
