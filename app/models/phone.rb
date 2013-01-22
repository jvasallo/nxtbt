class Phone < ActiveRecord::Base
  attr_accessible :description, :manufacturer, :name, :os, :rating, :release_date, :screen_size, :weight
  
  validates_presence_of :manufacturer, :name, :os, :rating, :release_date, :screen_size, :weight,
      :message => "must be filled!"
  validates_numericality_of :rating, :greater_than_or_equal_to => 0.0, :less_than_or_equal_to => 5.0,
      :message => "must be greater than or equal to 0.0, and less than 5.0!" 	  
  
  validate :check_release_date_for_range
  
  # validate that the phone is not older than 5 years old and that its not in the future
  def check_release_date_for_range
    if self.release_date < Date.today-5.years then
	  self.errors.add(:release_date, "must be greater than 5 years ago!")
	elsif self.release_date > Date.today then
	  self.errors.add(:release_date, "must be less than today!")
	end
  end
  
  
  #
  # Begin Virtual Attributes
  def pprint
    "#{manufacturer} #{name} -- (#{rating} / 5.0)"
  end
  
  def describe
	"Info: #{description}"
  end
  
  def tech_specs
	"OS: #{os}  Screen Size: #{screen_size}  Weight: #{weight}"
  end
  # End Virtual Attributes
  #
  
  # Display the top five phones in our system
  def self.top_five_phones
    Phone.all(:select => "manufacturer, name, rating",
	          :order => "rating DESC",
	          :limit => 5)
  end
  
  # Search by a specific manufacturer
  def self.by_manufacturer(search_manufacturer)
	where("manufacturer like ?", search_manufacturer)
  end
end
