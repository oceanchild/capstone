class Prescription < ActiveRecord::Base
  attr_accessible :direction, :doctor_id, :start_date, :end_date, :servings_per_day, :patient_id, :pill_name, :quantities_per_serving
end
