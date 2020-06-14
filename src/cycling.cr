require "csv"
require "./cycling/**"

module Cycling
  VERSION = "0.3.1"

  # Initializing
  Cycling::Options
  ENV["file"] ||= "./data.csv"

  # Create a new file if once doesn't exist
  def self.create_file
    File.touch(ENV["file"]) # Create new file
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
    File.write(ENV["file"], first_row) # Write to file
  end

  # Check if data file exist or create it
  File.exists?(ENV["file"]) ? true : Cycling.create_file

  # Create new row of test data
  def self.build_file
    # Prompt user for info
    puts "Enter your ride details..."
    puts "Fields are optional, just press ENTER to skip"
    print "Enter Date (YYYYMMDD):"
    d1 = read_line
    print "Enter Distance (Miles or Kilometers):"
    d2 = read_line
    print "Enter Time (Enter as Seconds):"
    d3 = read_line
    # d4 will be set below in the conversions
    print "Enter Max Speed (MPH or KPH):"
    d5 = read_line
    print "Enter Average Heart Rate:"
    d6 = read_line
    print "Enter Average Cadence (RPMs):"
    d7 = read_line
    print "Enter Comments:"
    d8 = read_line
    # Convert to nil to save on data size
    d1 = d1.empty? ? nil : d1.chomp.to_i
    d2 = d2.empty? ? nil : d2.chomp.to_f32
    d3 = d3.empty? ? nil : d3.chomp.to_f32
    d4 = d3.nil? || d2.nil? ? nil : (d3*60**2)/d2
    d5 = d5.empty? ? nil : d5.chomp.to_f32
    d6 = d6.empty? ? nil : d6.chomp.to_i16
    d7 = d7.empty? ? nil : d7.chomp.to_f32
    d8 = d8.empty? ? nil : d8.chomp
    # Build CSV Row
    result = CSV.build do |csv|
      csv.row d1, d2, d3, d4, d5, d6, d7, d8
    end
    # Write data to file
    File.write(ENV["file"], result, mode: "a")
  end

  Cycling.build_file
  # Some Text to know it all worked.
  puts "Success: Data written to #{ENV["file"]}."
end
