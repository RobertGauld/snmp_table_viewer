module SNMPTableViewer

  # Parent class for formatters. Which take data and headings and output it in a given format.
  # @abstract
  class Formatter

    # Create a new instance of Formatter.
    # @param data [Array<Array<#to_s>>] A two dimensional array containing objects in each cell (at 'address' data[row][col])
    # @param headings [Array<String, #to_s>] An array of headings for each column
    # @return [Formatter]
    def initialize(data:, headings: [])
        @headings = headings
        @data = data
    end

    private
    # Get a two dimensioan array of headings prepended to the data or just the data (if no headings were provided).
    # @return Array<Array<#to_s>>
    def data_with_headings
      has_headings? ? [@headings, *@data] : @data
    end
    # Determine if headings were passed.
    # @return [Boolean]
    def has_headings?
      @headings.is_a?(Array) && @headings.size > 0
    end

  end # Formatter base class

end # module SNMPTableViewer
