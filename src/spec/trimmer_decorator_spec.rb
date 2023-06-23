require_relative '../decorator/trimmer_decorator'

describe TrimmerDecorator do
  let(:nameable) { double('Nameable') }
  let(:trimmer) { TrimmerDecorator.new(nameable) }

  describe '#correct_name' do
    it 'trims the name returned by the nameable object to 10 characters' do
      allow(nameable).to receive(:correct_name).and_return('This is a long name')
      expect(trimmer.correct_name).to eq('This is a ')
    end

    it 'does not trim the name if it is already 10 characters or less' do
      allow(nameable).to receive(:correct_name).and_return('Short name')
      expect(trimmer.correct_name).to eq('Short name')
    end
  end
end
