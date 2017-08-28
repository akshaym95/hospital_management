class Registration < ActiveRecord::Base
  belongs_to :patient
  has_many :beds
end
