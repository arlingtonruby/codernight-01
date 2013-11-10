# Given a file, uses the from_xml method from ActiveSupport
# to convert it to a hash, then strips away the enclosing
# tags to obtain an array suitable for using in the rest
# of this problem.
class CurrencyXmlFileParser

  def self.parse(file)
    Hash.from_xml(File.read(file))["rates"]["rate"]
  end
end
