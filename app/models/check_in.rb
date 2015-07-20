class CheckIn < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :name, :message

  validates :lat , numericality: { greater_than_or_equal_to:  -90, less_than_or_equal_to:  90 }, allow_nil: true
  validates :lng, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }, allow_nil: true

end
