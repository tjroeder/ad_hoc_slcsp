require 'optparse'

class CliParser
  attr_accessor :options

  # Default output path to slcsp_output.csv to keep original file in case of error during processing
  def initialize
    @options = { output_path: './data/slcsp_out.csv' }
  end

  # Parse, check and define for given ARGV file path arguments
  def define_options(args)
    OptionParser.new do |opts|
      opts.banner = "Usage: find_slcsp_rates.rb [path_option] relative filepath\n\nRequired CSV file paths: Plans CSV file path, Zips CSV file path, SLCSP CSV file path\n\nOptional CSV file path: Output file path"
      opts.separator ''

      opts.on('--plans_path PATH', String, 
              'Required CSV Plans file path') do |path|
        @options[:plans_path] = path
      end
    
      opts.on('--zips_path PATH', String, 
              'Required CSV Zips file path') do |path|
        @options[:zips_path] = path
      end
    
      opts.on('--slcsp_path PATH', String, 
              'Required CSV SLCSP file path') do |path|
        @options[:slcsp_path] = path
      end

      opts.on('--output_path [PATH]', String, 
              'Optional CSV SLCSP output file path, Default: ./data/slcsp_out.csv') do |path|
        @options[:output_path] = path unless path.nil?
      end
    
      opts.separator ''
    
      opts.on('-h', '--help', 'Show this message') do
        puts opts
        exit
      end
    end.parse!(args)
    check_for_paths
  end

  # Check that required filepaths are given
  def check_for_paths
    path_options = { 
                     plans: '--plans_path', 
                     zips: '--zips_path', 
                     slcsp: '--slcsp_path'
                   }
    errors = []
    errors << path_options[:plans] if @options[:plans_path].nil?
    errors << path_options[:zips] if @options[:zips_path].nil?
    errors << path_options[:slcsp] if @options[:slcsp_path].nil?

    raise OptionParser::MissingArgument.new(errors) if errors.count.positive?
  end
end
