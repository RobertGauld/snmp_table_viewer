module SNMPTableViewer

  # Class to fetch the information from an SNMP host.
  class Fetcher

    # Fetch the data using SNMP.
    # @param base_oid [String] The OID to start the SNMP walk from
    # @param **snmp_options [Hash] The options to pass to NETSNMP::Client.new
    # @return [Array<Array<#to_s>>] A two dimensional array containing objects in each cell (at 'address' data\[row\]\[col\])
    def self.from_snmp(base_oid:, **snmp_options)
      data = Array.new
      NETSNMP::Client.new(snmp_options) do |manager|
        manager.walk(oid: base_oid).each do |oid, value|
          col, row = oid.split('.')[-2..-1].map{ |i| i.to_i - 1}
          data[row] ||= Array.new
          data[row][col] = value
        end
      end
      data
    end

    # Build the data from an Array<String>.
    #   Each String of the format returned by the snmpwalk command ("<oid> = <type>: <value>").
    # @param data [Array<String>] The Strings to get the data from
    # @return [Array<Array<#to_s>>] A two dimensional array containing objects in each cell (at 'address' data\[row\]\[col\])
    def self.from_array(data_in)
      data_out = Array.new
      regexp_general = Regexp.compile(/\A(?:iso)?[\.0-9]+\.([0-9]+)\.([0-9]+)\s+=\s+([A-Za-z0-9 \-]+):\s+(.+)\Z/)
      regexp_nodata = Regexp.compile(/\A(?:iso)?[\.0-9]+\.([0-9]+)\.([0-9]+)\s+=\s+""\Z/)
      data_in.each.with_index do |line, index|
        # Try to get a match on the various valid frmats of line
        match = line.match(regexp_general)
        match ||= line.match(regexp_nodata)
        if match.nil?
          STDERR.puts "Could not parse data on line #{index+1}: #{line}"
          next
        end

        col, row, type, value = match.captures
        # Convert value
        case type && type.downcase
          when nil
          when 'string'
            value = value[1..-2] # Strip enclosing quotes
          when 'oid', 'hex-string'
          when 'integer', 'integer32', 'uinteger32', 'gauge32', 'counter32', 'counter64'
            value = value.to_i
          when 'ipaddress'
            value = IPAddr.new(value)
          when 'timeticks'
            match = value.match(/\A\((\d+)\)/)
            value = NETSNMP::Timetick.new(match.nil? ? 0 : match[1].to_i)
          else
            STDERR.puts "Unknown SNMP type (#{type}) on line #{index+1}: #{line}"
        end
        
        # Save value
        row = row.to_i - 1
        col = col.to_i - 1
        data_out[row] ||= Array.new        
        data_out[row][col] = value
      end # each line of data_in
      data_out
    end

  end # class Fetcher

end # module SNMPTableViewer
