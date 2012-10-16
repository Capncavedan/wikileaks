require 'rubygems'
require 'csv'

i = 1

f = File.open("/Users/danb/Desktop/sample.csv", 'rb')

CSV.foreach( f, {row_sep: "\n\n"} ) do |record|
  puts i
  i += 1
end