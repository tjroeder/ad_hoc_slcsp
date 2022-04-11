require_relative './plan'
require_relative './zip'
require_relative './slcsp'
require 'csv'

class CsvReadWrite
  attr_accessor :plans_data,
                :zips_data,
                :slcsp_data

  def initialize(data)
    @plans_data = read_csv(data[:plans_path])
    @zips_data = read_csv(data[:zips_path])
    @slcsp_data = read_csv(data[:slcsp_path])
    create_models
  end

  # Read the CSV and save as CSV object data
  def read_csv(path)
    CSV.read(path, headers: true, header_converters: :symbol)
  end

  # Create Plan, Zip, and SLCSP models from the CSV data
  def create_models
    @plans_data.each do |plan|
      Plan.new(plan)
    end
    
    @zips_data.each do |zip|
      Zip.new(zip)
    end
  
    @slcsp_data.each do |slcsp|
      Slcsp.new(slcsp)
    end
  end

  # Save SLCSP rates to output csv, and print the CSV contents to STDOUT
  def save_print_slcsp_rates(file_output_path)
    new_csv = CSV.open(file_output_path, 'w+', headers: @slcsp_data.headers, write_headers: true)
    printf("%s,%s\n", @slcsp_data.headers[0], @slcsp_data.headers[1])
  
    @slcsp_data.each do |row|
      new_row = [row[:zipcode], Slcsp.find_by_zipcode(row[:zipcode]).rate]
      printf("%7s,%s\n", new_row[0], new_row[1])
  
      new_csv << new_row
    end
    new_csv.close
  end
end
