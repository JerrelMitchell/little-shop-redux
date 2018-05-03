require 'csv'

# handles reading of csv files for database seeds
class CSVWizard
  def self.read_file(filename)
    CSV.open(filename,
             headers: true,
             header_converters: :symbol)
  end
end
