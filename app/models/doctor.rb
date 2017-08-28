class Doctor < User 
  belongs_to :department
  has_many :appointments,:dependent => :destroy
  has_many :patients, :through => :appointments
  validates_presence_of :name
end
