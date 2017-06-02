module SNMPTableViewer

  # Formatting class for JSON output
  class Formatter::JSON < Formatter
    # Output the data. If no headings are provided you'll get an Array or Arrays. If headings are provided you'll get an Array of Hashes.
    # @return [String] the JSON data
    def output()
      data = @data
      if @headings.size > 0
        # Convert inner arrays to hashes
        data = data.map{ |row| Hash[row.map.with_index{ |value, index| [@headings[index] || '', value] }] }
      end
      ::JSON.generate(data)
    end
  end # JSON Formatter

end # module SNMPTableViewer
