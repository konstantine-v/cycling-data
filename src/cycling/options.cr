require "option_parser"
require "../cycling"

class Cycling::Options
  # Option Flags to select different options for things
  OptionParser.parse do |p|
    p.banner = "Usage: cycling [arguments]"
    p.on("-o", "--output", "Output the data to I/O for use in other programs") do
      puts "Not Available"
      exit
    end
    p.on("-f PATH", "--file PATH", "Choose file to write to") do |new_path|
      ENV["file"] = new_path.empty? ? "data.csv" : new_path
    end
    p.on("-a", "--aat", "Put path to AAT data file to input") do
      puts "Not Available"
      exit
    end
    p.on("-h", "--help", "Show this help") do
      puts p
      exit
    end
    # If flag unknown show help but show error
    p.invalid_option do |flag|
      STDERR.puts "ERROR: #{flag} is not a valid option."
      STDERR.puts p
      exit(1)
    end
  end
end
