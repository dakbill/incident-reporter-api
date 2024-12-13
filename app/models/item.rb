class Item < ApplicationRecord
    belongs_to :incident , required: false
end
