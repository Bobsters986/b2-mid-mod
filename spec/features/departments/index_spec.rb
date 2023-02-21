require 'rails_helper'

RSpec.describe 'Departments Index', type: :feature do
  let!(:it) { Department.create!(name: 'IT', floor: 'Top Level') }
  let!(:finance) { Department.create!(name: 'Finance', floor: 'Basement') }
  let!(:axel) { it.employees.create!(name: 'Axel', level: 5) }
  let!(:meredith) { finance.employees.create!(name: 'Meredith', level: 0) }

  describe 'when I visit /departments' do
    it 'I see a departments info and all of its employees' do
      visit '/departments'

      expect(page).to have_content("Name: #{it.name}")
      expect(page).to have_content("Floor: #{it.floor}")
      expect(page).to have_content("Name: #{finance.name}")
      expect(page).to have_content("Floor: #{finance.floor}")
    end

    it 'I see a list of each departments employees' do
      visit '/departments'
      
      expect(page).to have_content("Name: #{axel.name}")
      expect(page).to have_content("Name: #{meredith.name}")
    end
  end
end