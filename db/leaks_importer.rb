require 'rubygems'
require 'csv'

f = File.open("/Users/danb/Downloads/cables.csv", 'rb')
data = f.read(1 * 1024 *1024)
f.close

i = 1

while data.sub!(/("\d+","\d{1,2}\/\d{1,2}\/\d{4} \d{1,2}:\d\d",.*?)\n("\d+","\d{1,2}\/\d{1,2}\/\d{4} \d{1,2}:\d\d.*?")/m, '\2')
  cable = String.new($1)
  cable.gsub!(/\\"/, '""')
  cable.gsub!(/\\'/, "'")

  # "1","12/28/1966 18:48","66BUENOSAIRES2481","Embassy Buenos Aires","UNCLASSIFIED","66STATE106206","P R 281848Z DEC 66...
  # "2","2/25/1972 9:30","72TEHRAN1164","Embassy Tehran","UNCLASSIFIED","72MOSCOW1603|72TEHRAN1091|72TEHRAN263","R 250930Z FEB 72...
  CSV.parse(cable) do |row|
    numeric_id, sent_at, id_one, origin, classification, id_two, header, body = row
    puts origin
    i += 1
  end
end

puts "Processed #{i} cables"