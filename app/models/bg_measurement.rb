class BgMeasurement < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :presence => true
  validates :user_email_bg_timestamp, :presence => true
  validates :user_email_bg_timestamp, :uniqueness => true
  validates :measurement_time, :presence => true
  TIMES_OF_DAY = ["Morning (5AM to 10AM)", "Noonish (10AM to 2PM)","Afternoon (2PM to 6PM)", "Evening (6PM to 9PM)", "Night (9PM to Midnight)", "Twilight (Midnight to 5AM)"]
  BG_ASSESSMENTS = ["Very Low (<50)", "Low (50-75)", "Optimal (75-140)", "OK (140-180)", "Somewhat High (180-220)", "High (220-300)", "Very High (300+)"]

  default_scope { order("measurement_time asc") }
  
  before_save do |r|
    r.eastern_us_mtime = r.measurement_time + 4.hours
    r.pacific_us_mtime = r.measurement_time + 1.hour
    r.time_of_day = r.get_time_of_day
    r.bg_assessment = r.get_bg_assessment
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
  
  def get_bg_assessment
    bg = mg_dl
    if mg_dl <= 50
      "Very Low (<50)"
    elsif mg_dl.between?(50, 75)
      "Low (50-75)"
    elsif mg_dl.between?(75, 140)
      "Optimal (75-140)"
    elsif mg_dl.between?(140, 180)
      "OK (140-180)"
    elsif mg_dl.between?(180, 220)
      "Somewhat High (180-220)"
    elsif mg_dl.between?(220, 300)
      "High (220-300)"
    elsif mg_dl > 300
      "Very High (300+)"
    else
      raise "something is wrong!"
    end
  end
  
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
