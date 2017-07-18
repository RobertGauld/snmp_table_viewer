module SNMPTableViewer

  # Converter for the interface table.
  #   Replaces type with "number (meaning)"
  #   Replaces admin state with "number (meaning)"
  #   Replaces oper state with "number (meaning)"
  #   Replaces last change with "Timeticks: (number) D days, H:M:S.ms"
  class Converter::IfTable < Converter
    ADMIN_STATES = ['up', 'down', 'testing']
    OPER_STATES = ['up', 'down', 'testing', 'unknown', 'dormant', 'notPresent', 'lowerLayerDown']
    TYPES = CSV.read(File.join(__dir__, '..', '..', '..', 'data', 'iftable', 'type.tsv'), col_sep: "\t").each{ |i| i[0] = i[0].to_i }.to_h
    private_constant :ADMIN_STATES, :OPER_STATES, :TYPES

    def self.convert(data)
      data.map do |item|
        item[2] = "#{item[2]} (#{TYPES[item[2]]})"
        item[6] = "#{item[6]} (#{ADMIN_STATES[item[6]-1]})"
        item[7] = "#{item[7]} (#{OPER_STATES[item[7]-1]})" 
        item[8] = item[8].to_s # Timeticks for last change
        item
      end
    end
  end # IfTable Converter

end # module SNMPTableViewer
