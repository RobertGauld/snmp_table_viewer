module SNMPTableViewer

  class Formatter

    def initialize(data:, headings: [], **options)
        @headings = headings
        @data = data
    end

    private
    def data_with_headings
      has_headings? ? [@headings, *@data] : @data
    end
    def has_headings?
      @headings.is_a?(Array) && @headings.size > 0
    end

  end # Formatter base class

end # module SNMPTableViewer
