module SNMPTableViewer

  class Formatter::Raw < Formatter
    def output(**options)
      data_with_headings.inspect
    end
  end # Raw Fromatter

end # module SNMPTableViewer
