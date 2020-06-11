require "option_parser"
require "csv"

module Cycling
  VERSION = "0.1.4"
  @@data      : String = "data.csv"

  # Option Flags to select different options for things
  OptionParser.parse do |parser|
    parser.banner = "Usage: cycling [arguments]"
    parser.on("-o", "--output", "Output the data to I/O for use in other programs"){puts "Not Available yet..."}
    parser.on("-h", "--help", "Show this help") do
      puts parser
      exit
    end
    # If flag unknown show help but show error
    parser.invalid_option do |flag|
      STDERR.puts "ERROR: #{flag} is not a valid option."
      STDERR.puts parser
      exit(1)
    end
  end

  # Create a new file if once doesn't exist
  def self.create_file()
    File.touch(@@data) # Create new file
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
    File.write(@@data, first_row) # Write to file
  end

  # Check if data file exist or create it
  File.exists?(@@data) ? true : Cycling.create_file()

  # Create new row of test data
  def self.build_file()
    # Prompt user for info
    puts "Enter your ride details..."
    puts "Fields are optional, just press enter to skip"
    print "Enter Date (YYYYMMDD):"
    d1 = read_line
    pp d1
    print d1
    print "Enter Distance (Miles or Kilometers):"
    d2 = read_line
    puts d2
    print "Enter Time (Enter as Seconds):"
    d3 = read_line
    # d4 will be set below in the conversions
    print "Enter Max Speed (mph/kmph):"
    d5 = read_line
    print "Enter Average Heart Rate:"
    d6 = read_line
    print "Enter Average Cadence (rmp):"
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
    d7 = d7.empty? ? nil : d7.chomp

    result = CSV.build do |csv|
      csv.row d1,d2,d3,d4,d5,d6,d7,d8
    end

    # Write data to file
    File.write(@@data, result, mode: "a")
  end
  Cycling.build_file()
  # Some Text to know it all worked.
  puts "Success: Data written to #{@@data}."
end
