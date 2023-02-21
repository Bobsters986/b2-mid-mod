require 'rails_helper'

RSpec.describe 'Employee Show', type: :feature do
  let!(:it) { Department.create!(name: 'IT', floor: 'Top Level') }
  let!(:finance) { Department.create!(name: 'Finance', floor: 'Basement') }
  let!(:axel) { it.employees.create!(name: 'Axel', level: 5) }
  let!(:meredith) { finance.employees.create!(name: 'Meredith', level: 0) }
  let!(:bug) {Ticket.create!(subject: 'Bug', age: 1)}
  let!(:refactor) {Ticket.create!(subject: 'Refactor', age: 3)}
  let!(:error) {Ticket.create!(subject: 'Error', age: 5)}

  before do
    EmployeeTicket.create!(ticket: bug, employee: axel)
    EmployeeTicket.create!(ticket: refactor, employee: axel)
  end

  describe 'when I visit /employees/:id' do
    it 'I see the employee info' do
      visit "/employees/#{axel.id}"

      expect(page).to have_content("#{axel.name}'s Page")
      expect(page).to have_content("Department Name: #{axel.department.name}")
    end

    it 'I see the employees tickets' do
      visit "/employees/#{axel.id}"
      
      expect(page).to have_content("Subject: #{bug.subject}")
      expect(page).to have_content("Age: #{bug.age}")
      expect("Refactor").to appear_before("Bug")
    end

    it 'I see the tickets listed by oldest to newest, as well as oldest listed separately' do
      visit "/employees/#{axel.id}"
      
      expect("Refactor").to appear_before("Bug")
      expect(page).to have_content("Oldest Ticket: #{refactor.subject}")
    end

    it 'I see a form to add a ticket to the employee' do
      visit "/employees/#{axel.id}"
      
      expect(page).to have_field(:ticket_id)
      expect(page).to have_button(:Submit)
    end

    it 'I can add the ticket ID and remain on the employees show page where I see the new ticket' do
      visit "/employees/#{axel.id}"

      fill_in :ticket_id, with: error.id
      click_button :Submit

      save_and_open_page

      expect(current_path).to eq("/employees/#{axel.id}")
      expect(page).to have_content("Subject: #{error.subject}")
      expect(page).to have_content("Age: #{error.age}")
    end
  end
end