class Prescription < ActiveRecord::Base
  attr_accessible :direction, :doctor_id, :start_date, :end_date, :frequency_per_day, :patient_id, :pill_id, :quantity_each_serving
end
