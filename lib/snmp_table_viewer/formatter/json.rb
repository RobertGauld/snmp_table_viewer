module SNMPTableViewer

  class Formatter::JSON < Formatter
    def output(**options)
      data = @data
      if @headings.size > 0
        # Convert inner arrays to hashes
        data = data.map{ |row| Hash[row.map.with_index{ |value, index| [@headings[index] || '', value] }] }
      end
      ::JSON.generate(data)
    end
  end # JSON Formatter

end # module SNMPTableViewer
