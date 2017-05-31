module SNMPTableViewer

  class Fetcher

    def initialize(**snmp_options)
      @snmp_options = snmp_options
    end


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
