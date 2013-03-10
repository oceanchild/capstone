class Prescription < ActiveRecord::Base
  attr_accessible :direction, :doctor_id, :end_date, :frequency_per_day, :patient_id, :pill_id, :quantity_each_serving, :start_date
end
