class Slcsp
  attr_reader :zipcode
  attr_accessor :rate
  @@all = []
  
  def initialize(slcsp_data)
    @zipcode = slcsp_data[:zipcode]
    @rate    = slcsp_data[:rate]
    @@all    << self
  end

  # Class Methods
  def self.all
    @@all
  end

  # Search all zipcode objects by zipcode
  def self.find_by_zipcode(zipcode)
    @@all.find{ |i| i.zipcode == zipcode }
  end

  # Set all SLCSP rates, if zipcode is ambiguous set the rate to nil.
  def self.set_slcsp_rates_from_zip(checked_groups)
    @@all.each do |slcsp|
      zipcode = checked_groups[slcsp.zipcode.to_s]
      if zipcode.nil?
        slcsp.rate = nil
      else
        slcsp.rate = Plan.find_slcsp_rate(zipcode.state, zipcode.rate_area)
      end
    end
  end
end
