class Employee < ApplicationRecord
  belongs_to :department
  has_many :employee_tickets
  has_many :tickets, through: :employee_tickets

  def self.coworker_ticket_shared(employee)
    joins(:employee_tickets).where(employee_tickets: {ticket_id: employee.tickets.ids}).where.not(id: employee.id).distinct
  end
end