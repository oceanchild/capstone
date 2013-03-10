class Note < ActiveRecord::Base
  attr_accessible :author_id, :content, :date_created, :patient_id, :reply_to_note
end
