class EmployeesController < ApplicationController
  def show
    @employee = Employee.find(params[:id])
    @tickets = @employee.tickets.sorted_by_age_desc
    @shared_names = Employee.coworker_ticket_shared(@employee).pluck(:name)
  end
end