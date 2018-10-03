class Deadline < ApplicationRecord
  belongs_to :due_date, polymorphic: true
end
