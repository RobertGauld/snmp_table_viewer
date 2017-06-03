# Require gems
require 'netsnmp'
require 'terminal-table'

# Require from standard ruby libraries
require 'csv'
require 'json'

# Load the other files in the lib directory
require_relative '../version'
Dir["#{File.dirname(__FILE__)}/**/*.rb"].select{ |f| f != __FILE__}.sort.each { |f| load(f) }

module SNMPTableViewer

  HEADINGS_FOR = {
      'ifTable' => ['Index', 'Descr', 'Type', 'Mtu', 'Speed', 'PhysAddress', 'AdminStatus', 'OperStatus', 'LastChange', 'InOctets', 'InUcastPkts', 'InNUcastkts', 'InDiscards', 'InErrors', 'InUnknownPrortos', 'OutOctets', 'OutUcastPkts', 'OutNUcastPkts', 'OutDiscards', 'OutErrors', 'OutQLen', 'Specific'],
  }.freeze

  FORMATTERS = {
      'table' => SNMPTableViewer::Formatter::Table,
      'csv' =>   SNMPTableViewer::Formatter::CSV,
      'json' =>  SNMPTableViewer::Formatter::JSON,
      'raw' =>   SNMPTableViewer::Formatter::Raw,
  }.freeze

  CONVERTERS = {
    'iftable' => SNMPTableViewer::Converter::IfTable,
  }.freeze

  BASE_OIDS = {
    'iftable' => '1.3.6.1.2.1.2.2',
  }.freeze

end # module SNMPTableViewer
