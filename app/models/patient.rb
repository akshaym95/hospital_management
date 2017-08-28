class Patient < User
  has_many :appointments,:dependent => :destroy
  has_many :doctors, :through => :appointments
  has_many :registrations,:dependent => :destroy
  has_many :beds, :through=> :registrations
  validates_presence_of :name
end
