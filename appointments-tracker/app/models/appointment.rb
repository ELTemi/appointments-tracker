class Appointment < ActiveRecord::Base
  validates_presence_of :title, :date, :location, :details
  belongs_to :user
end
