describe SNMPTableViewer::Fetcher do

  it 'Create' do
    expect(described_class.new()).to_not be_nil
  end

  it 'Fetches' do
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
    fetcher = described_class.new(snmp_options)
    expect(fetcher.fetch('1.2.3.4.5')).to eq [
      [1, 'a', 'A'],
      [2, 'b', 'B']
    ]
  end

end
