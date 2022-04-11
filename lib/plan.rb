class Plan
  attr_reader :plan_id,
              :state,
              :metal_level,
              :rate,
              :rate_area
  @@all = []

  def initialize(plan_data)
    @plan_id     = plan_data[:plan_id]
    @state       = plan_data[:state]
    @metal_level = plan_data[:metal_level]
    @rate        = plan_data[:rate]
    @rate_area   = plan_data[:rate_area]
    @@all        << self
  end

  # Class Methods
  def self.all
    @@all
  end

  # Filter plans by metal level status
  def self.silver_plans
    @@all.select do |plan|
      plan.metal_level == 'Silver'
    end
  end

  # Filter Silver plans by state and rate area
  def self.find_state_rate_area_silver_plans(state, rate_area)
    silver_plans.select do |plan| 
      plan.state == state && plan.rate_area == rate_area
    end
  end

  # Find the second lowest cost silver rate plan give state and rate area, return nil if the there is no second lowest cost plan
  def self.find_slcsp_rate(state, rate_area)
    plans = find_state_rate_area_silver_plans(state, rate_area)
    uniq_sorted_rate_plans = plans.uniq(&:rate).sort_by(&:rate)
    
    if uniq_sorted_rate_plans.count > 1
      return sprintf("%.2f", uniq_sorted_rate_plans[1].rate)
    else
      return nil
    end
  end
end
