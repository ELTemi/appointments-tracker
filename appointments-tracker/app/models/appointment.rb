class Appointment < ActiveRecord::Base
  validates_presence_of :title, :date, :location
  belongs_to :user
end
