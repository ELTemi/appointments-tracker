class Appointment < ActiveRecord::Base
  validates_presence_of :title, :date, :location, :details
  validates_uniqueness_of :title
  belongs_to :user
end
