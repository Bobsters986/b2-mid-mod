class EmployeeTicketsController < ApplicationController
  def create
    ticket = Ticket.find(params[:ticket_id])
    et = EmployeeTicket.new(ticket: ticket, employee_id: params[:id])

    if et.save
      redirect_to "/employees/#{params[:id]}"
    else
      flash[:alert] = et.errors.full_messages.join
    end
  end
end