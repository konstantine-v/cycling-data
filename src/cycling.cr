require "option_parser"
require "csv"

module Cycling
  VERSION = "0.1.2"

  # Notes
  # Currently just works as a test version, it does the very very basic functions.
  # TODO: Break out into components
  # TODO: Have OptionParser create flags for use in the application.

  # Set the data file
  @@data_date : Int32   = 0
  @@data_dist : Float64 = 0
  @@data_time : Float64 = 0
  @@data_avgs : Float64 = 0
  @@data_maxs : Float64 = 0
  @@data_ahrt : Int32   = 0
  @@data_cadn : Float64 = 0
  @@data_comm : String = ""
  data = "data.csv"

  # Create a new file if once doesn't exist
  def self.create_file(data)
    File.touch(data) # Create new file

    # Create Header Row
    first_row = CSV.build do |csv|
      csv.row "Date",
              "Distance",
              "Time",
              "Average Speed",
              "Maximum Speed",
              "Average Heart Rate",
              "Cadence",
              "Comments"
    end

    File.write(data, first_row) # Write to file
  end

  # Check if data file exist or create it
  File.exists?(data) ? true : Cycling.create_file(data)

  # Create new row of test data
  def self.build_file()
    # Prompt user for info
    puts "Enter your ride details..."
    puts "Fields are optional, just press enter to skip"
    print "Enter Date (YYYYMMDD):"
    d1 = read_line.chomp.to_i
    print "Enter Distance (Miles or Kilometers):"
    d2 = read_line.chomp.to_f
    print "Enter Time (Enter as Seconds):"
    d3 = read_line.chomp.to_f

    d4 = (d3*60**2)/d2
   
    print "Enter Max Speed (mph/kmph):"
    d5 = read_line.chomp.to_f
    print "Enter Average Heart Rate:"
    d6 = read_line.chomp.to_i
    print "Enter Average Cadence (rmp):"
    d7 = read_line.chomp.to_f
    print "Enter Comments:"
    d8 = read_line.chomp

    @@data_date = d1.nil? ? 0   : d1
    @@data_dist = d2.nil? ? 0.0 : d2
    @@data_time = d3.nil? ? 0.0 : d3
    @@data_avgs = d4.nil? ? 0.0 : d4
    @@data_maxs = d5.nil? ? 0.0 : d5
    @@data_ahrt = d6.nil? ? 0   : d6
    @@data_cadn = d7.nil? ? 0.0 : d7
    @@data_comm = d8.nil? ? ""  : d8
  end

  Cycling.build_file()
  result = CSV.build do |csv|
    csv.row @@data_date,
            @@data_dist,
            @@data_time,
            @@data_avgs,
            @@data_maxs,
            @@data_ahrt,
            @@data_cadn,
            @@data_comm
  end
  # Write data to file
  File.write(data, result, mode: "a")

  # Some Text to know it all worked.
  puts "Success: Data written to #{data}."
end
