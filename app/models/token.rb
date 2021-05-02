class Token < ApplicationRecord
  enum status: [ :inactive, :active ]
  belongs_to :user
end
