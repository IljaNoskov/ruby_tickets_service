require 'rails_helper'

RSpec.describe Visitor, type: :model do
  subject do
    described_class.new(
      first_name: 'Евгений',
      last_name: 'Черкасов',
      middle_name: 'Олегович',
      birthdate: Date.current,
      document_type: 'passport',
      document_number: '1234123456'
    )
  end

  context 'valid' do
    it 'with valid attributes' do
      subject.run_callbacks(:save)

      expect(subject).to be_valid
    end

    it 'without middle name' do
      subject.middle_name = nil
      subject.run_callbacks(:save)

      expect(subject).to be_valid
    end

    it 'with valid license number' do
      subject.document_type = 'license'
      subject.document_number = '12 АБ 1234'
      subject.run_callbacks(:save)

      expect(subject).to be_valid
    end

    it 'with valid birth certificate number' do
      subject.document_type = 'certificate'
      subject.document_number = 'VI АЯ 123456'
      subject.run_callbacks(:save)

      expect(subject).to be_valid
    end
  end

  context 'invalid' do
    it 'with invalid names' do
      subject.first_name = 'При23'
      subject.last_name = 'При23'
      subject.middle_name = 'При23'

      expect(subject).to_not be_valid
      expect(subject.errors.size).to eq(3)
    end

    it 'with invalid document number' do
      subject.document_number = '1234'

      expect(subject).to_not be_valid
    end
  end
end
