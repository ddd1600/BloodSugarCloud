class BgMeasurement < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :presence => true
  validates :user_email_bg_timestamp, :presence => true
  validates :user_email_bg_timestamp, :uniqueness => true
  validates :measurement_time, :presence => true
  
  before_save do |r|
    r.time_of_day = r.get_time_of_day
  end
    
  def self.import_csv(file, current_user)
    puts "attempting to upload data..."
    rows = CSV.open(file.path).read
    rows.shift
    rows.each_with_index do |row, i|
      if row[0] == "Blood Sugar Reading"
        puts "Item Type = Blood Sugar Reading. Attempting to save."
        r = new
        r.mg_dl = row[2]
        r.notes = row[5]
        r.patient_name = current_user.name
        r.user_id = current_user.id
        r.measurement_time = Time.strptime(row[1], "%m/%e/%y, %l:%M %p")
        r.user_email_bg_timestamp = "#{current_user.email}_#{r.measurement_time.to_i}"
        r.save
        ap r
      end# of conditinal
    end# of csv rows
  end# of method
  
  def get_time_of_day
    hr = measurement_time.hour
    if hr.between?(5, 10)
      "Morning (5AM to 10AM)"
    elsif hr.between?(10, 2+12)
      "Noonish (10AM to 2PM)"
    elsif hr.between?(2+12, 6+12)
      "Afternoon (2PM to 6PM)"
    elsif hr.between?(6+12, 9+12)
      "Evening (6PM to 9PM)"
    elsif hr.between?(9+12, 12+12)
      "Night (9PM to Midnight)"
    elsif hr.between?(0, 5)
      "Twilight (Midnight to 5AM)"
    else
      raise "something is wrong (measurement_time = #{measurement_time})"
    end
  end
  
end
