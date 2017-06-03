describe SNMPTableViewer::Fetcher do

  it '#from_snmp' do
    snmp_options = {opt_a: :a}
    manager = double("manager")
    expect(manager).to receive(:walk).with(oid: '1.2.3.4.5').once.and_return([
      ['1.2.3.4.5.0.1.1', 1],
      ['1.2.3.4.5.0.1.2', 2],
      ['1.2.3.4.5.0.2.1', 'a'],
      ['1.2.3.4.5.0.2.2', 'b'],
      ['1.2.3.4.5.0.3.1', 'A'],
      ['1.2.3.4.5.0.3.2', 'B'],
    ]) # Array returned by manager doing the SNMP walk
    expect(NETSNMP::Client).to receive(:new).with(snmp_options).once do |&block|
      block.call(manager)
    end # expect block
    expect(described_class.from_snmp(base_oid: '1.2.3.4.5', **snmp_options)).to eq [
      [1, 'a', 'A'],
      [2, 'b', 'B']
    ]
  end

  describe '#from_array' do
    it 'Given array of strings "<oid> = <type>: <value>"' do
      data = [
        'iso.3.6.1.2.1.2.2.1.1.1 = INTEGER: 1',
        'iso.3.6.1.2.1.2.2.1.2.1 = STRING: "lo"',
        'iso.3.6.1.2.1.2.2.1.3.1 = Gauge32: 2',
        'iso.3.6.1.2.1.2.2.1.4.1 = Hex-STRING: 01 23 45 67 89 AB',
        'iso.3.6.1.2.1.2.2.1.5.1 = Timeticks: (10) 0:00:10.00',
        'iso.3.6.1.2.1.2.2.1.6.1 = Counter32: 3',
        'iso.3.6.1.2.1.2.2.1.7.1 = OID: ccitt.0',
        'iso.3.6.1.2.1.2.2.1.8.1 = IpAddress: 1.2.3.4',
        'iso.3.6.1.2.1.2.2.1.10.1 = ""',
      ]
      expect(described_class.from_array(data)).to eq [[
        1,
        'lo',
        2,
        '01 23 45 67 89 AB',
        NETSNMP::Timetick.new(10),
        3,
        'ccitt.0',
        IPAddr.new('1.2.3.4'),
        nil,
        nil
      ]]
    end

    it 'Errors but survives on a bad line' do
      data = ['This is a bad line', 'This is another bad line']
      expect(STDERR).to receive(:puts).with('Could not parse data on line 1: This is a bad line').once
      expect(STDERR).to receive(:puts).with('Could not parse data on line 2: This is another bad line').once
      expect(described_class.from_array(data)).to eq []
    end

    it 'Errors but survives on a bad type' do
      data = ['1.2.3.4.0.1.1 = INTEGER: 1', '1.2.3.4.0.2.1 = invalid-type: 1']
      expect(STDERR).to receive(:puts).with('Unknown SNMP type (invalid-type) on line 2: 1.2.3.4.0.2.1 = invalid-type: 1').once
      expect(described_class.from_array(data)).to eq [[1, '1']]
    end

  end # describe #from_array

end
