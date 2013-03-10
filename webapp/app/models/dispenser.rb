class Dispenser < ActiveRecord::Base
  attr_accessible :date_registered, :hash_code, :petient_id, :serial
end
