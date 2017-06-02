module SNMPTableViewer

  # Formatting class for Table output.
  class Formatter::Table < Formatter
    # Output the data (and headings if provided) as a table which can be displayed in the terminal.
    # @param transpose [Boolean] Whether to swap rows and columns - useful for displaying a wide and short table
    # @return [String] the text to display in order to draw the table
    def output(transpose: false)
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
        Terminal::Table.new(rows: data, headings: @headings).to_s
      else
        Terminal::Table.new(rows: data).to_s
      end
    end
  end # Table Formatter

end # module SNMPTableViewer
