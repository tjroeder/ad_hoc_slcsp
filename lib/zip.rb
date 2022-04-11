class Zip
  attr_reader   :zipcode,
                :state,
                :county_code,
                :name,
                :rate_area

  @@all = []

  def initialize(zip_data)
    @zipcode     = zip_data[:zipcode]
    @state       = zip_data[:state]
    @county_code = zip_data[:county_code]
    @name        = zip_data[:name]
    @rate_area   = zip_data[:rate_area]
    @@all        << self
  end

  # Class Methods
  def self.all
    @@all
  end

  # Group zips by their zipcodes and check for validity.
  def self.grouped_zips_by_zipcode
    grouped_zips = @@all.group_by(&:zipcode)
    checked_groups = {}

    grouped_zips.each_pair do |target, zipcodes|
      checked_groups[target.to_s] = check_zipcodes(zipcodes)
    end
    checked_groups
  end

  # Check zipcodes to verify no cross state or cross rate areas. If zipcodes inlcude multiple states or rate areas and are ambiguous, return nil.
  def self.check_zipcodes(zipcodes)
    if zipcodes.uniq { |zip| zip.rate_area && zip.state }.count == 1
      return zipcodes[0]
    else
      return nil
    end
  end
end
