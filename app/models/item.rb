# coding: utf-8
class Item < ActiveRecord::Base
  belongs_to :rubric
  geocoded_by :full_address
  after_validation :geocode, :if => :address_changed?
  
  validates :name, :presence => true
  validates :rubric_id, :presence => true
  validates :rubric_id, :numericality => { :only_integer => true }
  
  def full_address
    "Украина, Кировоград, #{self.address}"
  end
end
