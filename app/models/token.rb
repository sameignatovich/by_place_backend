class Token < ApplicationRecord
  enum access: [ :regular, :admin ]
  enum status: [ :inactive, :active ]
  belongs_to :user
end
