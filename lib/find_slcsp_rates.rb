require './lib/cli_parser'
require './lib/csv_read_write'

begin
  # Create new CLI parser to receive path arguments
  parser = CliParser.new
  parser.define_options(ARGV)

  # Save CSV data, and create plan, zip and slcsp models with path arguments
  csv_data = CsvReadWrite.new(parser.options)

  # Group all Zips by zipcode, then verify for cross state or cross rate area conditions
  checked_groups = Zip.grouped_zips_by_zipcode

  # Set all Slcsp zipcodes to their second lowest cost silver plan rates if able
  Slcsp.set_slcsp_rates_from_zip(checked_groups)

  # Print save the data
  csv_data.save_print_slcsp_rates(parser.options[:output_path])

# Rescue from any parse errors or file read/open errors
rescue OptionParser::MissingArgument => e
  puts %(OptionParser::MissingArgument: %s) % e.message
  exit
rescue OptionParser::ParseError => e
  puts %(OptionParser::ParseError: %s) % e.message
  exit
rescue Errno::ENOENT => e
  puts %(Errno::ENOENT: %s) % e.message
  exit
end
