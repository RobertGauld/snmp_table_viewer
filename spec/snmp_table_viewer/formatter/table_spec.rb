describe SNMPTableViewer::Formatter::Table do

  describe '#output' do

    it 'With headings' do
      headings = ['heading1', 'heading2', 'heading3']
      data = [
        ['row1col1', 'row1col2', 'a,b'],
        ['row2col1', 'row2col2', 'b,c']
      ]
      formatter = described_class.new(data: data, headings: headings)
      expect(formatter.output).to eq [
        '+----------+----------+----------+',
        '| heading1 | heading2 | heading3 |',
        '+----------+----------+----------+',
        '| row1col1 | row1col2 | a,b      |',
        '| row2col1 | row2col2 | b,c      |',
        '+----------+----------+----------+',
      ].join("\n")
    end

    it 'Without headings' do
      data = [
        ['row1col1', 'row1col2', 'a,b'],
        ['row2col1', 'row2col2', 'b,c']
      ]
      formatter = described_class.new(data: data)
      expect(formatter.output).to eq [
        '+----------+----------+-----+',
        '| row1col1 | row1col2 | a,b |',
        '| row2col1 | row2col2 | b,c |',
        '+----------+----------+-----+',
      ].join("\n")
    end

    context 'Transposes output' do

      it 'With headings' do
        headings = ['heading1', 'heading2', 'heading3']
        data = [
          ['row1col1', 'row1col2', 'a,b'],
          ['row2col1', 'row2col2', 'b,c']
        ]
        formatter = described_class.new(data: data, headings: headings)
        expect(formatter.output(transpose: true)).to eq [
          '+----------+----------+----------+',
          '| heading1 | row1col1 | row2col1 |',
          '| heading2 | row1col2 | row2col2 |',
          '| heading3 | a,b      | b,c      |',
          '+----------+----------+----------+',
        ].join("\n")
      end

      it 'Without headings' do
        data = [
          ['row1col1', 'row1col2', 'a,b'],
          ['row2col1', 'row2col2', 'b,c']
        ]
        formatter = described_class.new(data: data)
        expect(formatter.output(transpose: true)).to eq [
          '+----------+----------+',
          '| row1col1 | row2col1 |',
          '| row1col2 | row2col2 |',
          '| a,b      | b,c      |',
          '+----------+----------+',
        ].join("\n")
      end

    end # context transposes output

  end # describe #output

end
