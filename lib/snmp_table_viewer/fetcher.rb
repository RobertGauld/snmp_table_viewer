module SNMPTableViewer

  # Class to fetch the information from an SNMP host.
  class Fetcher

    # Create a new fetcher.
    # @param snmp_options [Hash] The options to pass to NETSNMP::Client.new
    # @return [Fetcher]
    def initialize(**snmp_options)
      @snmp_options = snmp_options
    end

    # Fetch the data using SNMP.
    # @param base_oid [String] The OID to start the SNMP walk from
    # @return [Array<Array<#to_s>>] A two dimensional array containing objects in each cell (at 'address' data[row][col])
    def fetch(base_oid)
      data = Array.new
      NETSNMP::Client.new(@snmp_options) do |manager|
        manager.walk(oid: base_oid).each do |oid, value|
          col, row = oid.split('.')[-2..-1].map{ |i| i.to_i - 1}
          data[row] ||= []
          data[row][col] = value
        end
      end
      data
    end

  end # class Fetcher

end # module SNMPTableViewer
