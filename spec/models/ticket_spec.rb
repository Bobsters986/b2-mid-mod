require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'relationships' do
    it { should have_many :employee_tickets }
    it { should have_many(:employees).through(:employee_tickets) }
  end

  describe "#class_methods" do
    let!(:bug) {Ticket.create!(subject: 'Bug', age: 1)}
    let!(:refactor) {Ticket.create!(subject: 'Refactor', age: 3)}

    it "#sorted_by_age_desc" do
      expect(Ticket.sorted_by_age_desc).to eq([refactor, bug])
    end
  end
end
