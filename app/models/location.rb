class Location < ApplicationRecord
    belongs_to :incident , required: true
end
