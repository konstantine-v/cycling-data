require "option_parser"
require "csv"

module Cycling
  VERSION = "0.1.1"

  # Notes
  # Currently just works as a test version, it does the very very basic functions.
  # TODO: Break out into components

  # Set the data file
  data = "data.csv"

  # Create a new file if once doesn't exist
  def self.create_file(data)
    File.touch(data) # Create new file

    # Create Header Row
    first_row = CSV.build do |csv|
      csv.row "Distance (km)", "Time (secs)", "Average Speed (km/h)", "Maximum Speed (km/h)", "Average Heart Rate", "Cadence", "Comments"
    end

    File.write(data, first_row) # Write to file
  end

  # Check if data file exist or create it
  File.exists?(data) ? true : Cycling.create_file(data)

  # TODO: Have OptionParser create flags for use in the application right around here.

  # Create new row of test data
  result = CSV.build do |csv|
    csv.row 30, 3600, 30, 35, 130, nil, nil
  end

  # Write data to file
  File.write(data, result, mode: "a")

  # Some Text to know it all worked.
  puts "Success: Data written to #{data}."
end
