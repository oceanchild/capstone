class Association < ActiveRecord::Base
  attr_accessible :patient_id, :user_id

  belongs_to :patient
  belongs_to :user
end
