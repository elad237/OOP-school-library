require_relative '../decorator/base_decorator'

describe BaseDecorator do
  let(:nameable) { double('Nameable') }
  let(:base_decorator) { BaseDecorator.new(nameable) }

  describe '#correct_name' do
    it 'delegates the correct_name method to the nameable object' do
      expect(nameable).to receive(:correct_name)
      base_decorator.correct_name
    end
  end
end
