module SNMPTableViewer

  class Formatter::Table < Formatter
    def output(transpose: false, **table_options)
      use_headings = @headings.size > 0
      data = @data

      if transpose
        # transpose the data
        if use_headings
          data = [@headings, *data].transpose
          use_headings = false # Don't add headings twice
        else
          data = data.transpose
        end
      end

      if use_headings
        Terminal::Table.new(rows: data, headings: @headings, **table_options).to_s
      else
        Terminal::Table.new(rows: data, **table_options).to_s
      end
    end
  end # Table Formatter

end # module SNMPTableViewer
