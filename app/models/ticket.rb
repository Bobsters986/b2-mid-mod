class Ticket < ApplicationRecord
  has_many :employee_tickets
  has_many :employees, through: :employee_tickets

  def self.sorted_by_age_desc
    order(age: :desc)
  end
end
