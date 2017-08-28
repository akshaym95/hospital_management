require 'bcrypt'
class User < ActiveRecord::Base
   has_attached_file :avatar, 
     :styles => { :medium => "300x300>", :thumb => "100x100>" }
  include BCrypt
  validates_presence_of :name
  attr_accessor :password
 
  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
  def role_symbols
    self.class.name.underscore.to_sym.to_a
  end
  
end
  

