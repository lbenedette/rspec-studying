class Account < ApplicationRecord
    def full_name
        "Sr. #{name}"
    end
end
