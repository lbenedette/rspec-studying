class Account < ApplicationRecord
    has_many :orders

    validates :country, presence: true

    def full_name
        "Sr. #{name}"
    end
end
