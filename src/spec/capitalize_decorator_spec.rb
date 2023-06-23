require_relative '../decorator/capitalize_decorator'

describe CapitalizeDecorator do
  let(:nameable) { double('Nameable') }
  let(:capitalize) { CapitalizeDecorator.new(nameable) }

  describe '#correct_name' do
    it 'capitalizes the name returned by the nameable object' do
      allow(nameable).to receive(:correct_name).and_return('john doe')
      expect(capitalize.correct_name).to eq('John doe')
    end
  end
end
