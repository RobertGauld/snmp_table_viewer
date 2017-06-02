module SNMPTableViewer

  # Formatting class for raw output.
  class Formatter::Raw < Formatter
    # Output the data (and headings if provided).
    # @return [String] the raw data
    def output()
      data_with_headings.inspect
    end
  end # Raw Fromatter

end # module SNMPTableViewer
