module SNMPTableViewer

  class Formatter::CSV < Formatter
    def output(**options)
      data_with_headings.map(&:to_csv).join
    end
  end # CSV Formatter

end # module SNMPTableViewer
