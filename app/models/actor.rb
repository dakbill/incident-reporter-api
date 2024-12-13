class Actor < ApplicationRecord
    belongs_to :incident , required: true
end
