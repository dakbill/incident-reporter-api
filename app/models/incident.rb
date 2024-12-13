class Incident < ApplicationRecord
    belongs_to :user , required: false
    has_many :items
    has_many :actors
    has_many :locations
end
