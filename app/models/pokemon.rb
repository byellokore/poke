class Pokemon < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :type_1
  validates_presence_of :total
  validates_presence_of :hp
  validates_presence_of :attack
  validates_presence_of :defense
  validates_presence_of :sp_atk
  validates_presence_of :sp_def
  validates_presence_of :speed
  validates_presence_of :generation
  validates_inclusion_of :legendary, in: [true, false]
  validates_uniqueness_of :name
end
