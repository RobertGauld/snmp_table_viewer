describe SNMPTableViewer::Formatter::CSV do

  describe '#output' do

    it 'With headings' do
      headings = ['heading1', 'heading2', 'heading3']
      data = [
        ['row1col1', 'row1col2', 'a,b'],
        ['row2col1', 'row2col2', 'b,c']
      ]
      formatter = described_class.new(data: data, headings: headings)
      expect(formatter.output).to eq "heading1,heading2,heading3\nrow1col1,row1col2,\"a,b\"\nrow2col1,row2col2,\"b,c\"\n"
    end

    it 'Without headings' do
      data = [
        ['row1col1', 'row1col2', 'a,b'],
        ['row2col1', 'row2col2', 'b,c']
      ]
      formatter = described_class.new(data: data)
      expect(formatter.output).to eq "row1col1,row1col2,\"a,b\"\nrow2col1,row2col2,\"b,c\"\n"
    end
    
  end # describe #output

end
