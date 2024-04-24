require 'rails_helper'

RSpec.describe Visitor, type: :model do

  context 'valid' do
    let(:visitor) { Visitor.new(first_name: 'Евгений', last_name: 'Черкасов', middle_name: 'Олегович',birthdate: Date.current) }

    it 'with valid attributes'
    it 'without middle name'
    it 'with valid license number'
    it 'with valid birth certificate number'
  end

  context 'invalid' do
    it 'with invalid names'
    it 'with invalid document type'
    it 'with invalid document number'
  end

end
