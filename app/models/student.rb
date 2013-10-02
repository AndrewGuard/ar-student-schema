require_relative '../../db/config'

class Student < ActiveRecord::Base

  validates_presence_of :email
  validates_uniqueness_of :email
  validate :validate_email
  validates :age, numericality: { greater_than: 5 }
  validate :validate_phone_number

  def validate_email
    self.errors.add :email, 'Invalid email' unless email =~ /.*[@]+.+[.]..+/
  end

  def validate_phone_number
    self.errors.add :phone, 'Invalid phone number' unless phone =~ /\(?\d*\)?\s\d*\-\d*(\sx\d*)?/
  end

  def name
    "#{first_name} #{last_name}"
  end

  def age
    now = Time.now.utc.to_date
    now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
  end

end
