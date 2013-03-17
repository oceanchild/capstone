class Prescription < ActiveRecord::Base
  attr_accessible :direction, :doctor_id, :start_date, :end_date, :servings_per_day, :patient_id, :pill_id, :quantities_per_serving
end
