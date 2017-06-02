module SNMPTableViewer

  # Formatting class for CSV output.
  class Formatter::CSV < Formatter
    # Output the data (and headings if provided).
    # @return [String] the CSV data
    def output()
      data_with_headings.map(&:to_csv).join
    end
  end # CSV Formatter

end # module SNMPTableViewer
