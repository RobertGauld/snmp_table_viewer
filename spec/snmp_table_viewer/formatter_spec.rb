describe SNMPTableViewer::Formatter do

  describe 'Create' do
    it "Requires data" do
      expect{described_class.new}.to raise_error(ArgumentError, 'missing keyword: data')
    end
    it "Has data" do
      expect(described_class.new(data: [])).to_not be_nil
      expect(described_class.new(data: [], headings: [])).to_not be_nil
    end
  end

  describe '#has_headings?' do
    it 'Headings are present' do
      formatter = described_class.new(data: [], headings: ['A heading'])
      expect(formatter.send(:has_headings?)).to be true
    end
    it 'Headings are not present' do
      formatter = described_class.new(data: [])
      expect(formatter.send(:has_headings?)).to be false
    end
    it 'Headings are not in an array' do
      formatter = described_class.new(data: [], headings: {})
      expect(formatter.send(:has_headings?)).to be false
    end
  end

  describe '#data_with_headings' do
    it 'Headings are present' do
      headings = ['heading1', 'heading2']
      data_line = ['data1', 'data2']
      formatter = described_class.new(data: [data_line], headings: headings)
      expect(formatter.send(:data_with_headings)).to eq [headings, data_line]
    end
    it 'Headings are not present' do
      data_line = ['data1', 'data2']
      formatter = described_class.new(data: [data_line])
      expect(formatter.send(:data_with_headings)).to eq [data_line]
    end
  end

end
