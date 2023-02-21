class EmployeesController < ApplicationController
  def show
    @employee = Employee.find(params[:id])
    @tickets = @employee.tickets.sorted_by_age_desc
  end
end