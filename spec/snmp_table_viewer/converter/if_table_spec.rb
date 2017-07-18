describe SNMPTableViewer::Converter::IfTable do

  describe '#convert' do
    let(:input) do
      [
        [1, "lo", 24, 65536, nil, "", 1, 2, NETSNMP::Timetick.new(100), 18985, 220, 0, 0, 0, 0, 18985, 220, 0, 0, 0, nil, "0.0"]
      ]
    end

    it 'Converts type' do
      output = described_class.convert(input)[0]
      expect(output[2]).to eq '24 (softwareLoopback)'
    end

    it 'Converts admin state' do
      output = described_class.convert(input)[0]
      expect(output[6]).to eq '1 (up)'
    end

    it 'Converts oper state' do
      output = described_class.convert(input)[0]
      expect(output[7]).to eq '2 (down)'
    end

    it 'Converts last change' do
      output = described_class.convert(input)[0]
      expect(output[8]).to eq 'Timeticks: (100) 0 days, 0:0:1.0'
    end

  end # describe #convert

end
