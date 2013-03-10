class MissedInstance < ActiveRecord::Base
  attr_accessible :missed_date, :patient_id, :prescription_id, :video_url
end
