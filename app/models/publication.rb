class Publication < ApplicationRecord
    has_many :broadcasts, dependent: :destroy
end
