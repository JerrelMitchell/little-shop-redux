require 'csv'

class CSVWizard
  def self.read_file(filename)
    CSV.open(filename,
             headers: true,
             header_converters: :symbol)
  end
end
