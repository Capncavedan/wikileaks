require 'rubygems'
require 'csv'

f = File.open("/Users/danb/Downloads/cables.csv", 'rb')
data = f.read(10 * 1024 *1024)
f.close

i = 1

while data.sub!(/("\d+","\d{1,2}\/\d{1,2}\/\d{4} \d{1,2}:\d\d",.*?)\n("\d+","\d{1,2}\/\d{1,2}\/\d{4} \d{1,2}:\d\d.*?")/m, '\2')
  cable = String.new($1)
  cable.gsub!(/\\"/, '""')
  cable.gsub!(/\\'/, "'")

  # "1","12/28/1966 18:48","66BUENOSAIRES2481","Embassy Buenos Aires","UNCLASSIFIED","66STATE106206","P R 281848Z DEC 66...
  # "2","2/25/1972 9:30","72TEHRAN1164","Embassy Tehran","UNCLASSIFIED","72MOSCOW1603|72TEHRAN1091|72TEHRAN263","R 250930Z FEB 72...
  CSV.parse(cable) do |row|
    numeric_id, cable_date, origin_id, origin_description, classification, destination_id, header, body = row
    puts origin_id
    i += 1

    leak = Leak.find_or_initialize_by_id(numeric_id)
    leak.cable_date = DateTime.now #parse(cable_date)
    leak.origin_id = origin_id
    leak.origin_description = origin_description
    leak.classification = classification
    leak.destination_id = destination_id
    leak.header = header
    leak.body = body
    leak.save
  end
end

puts "Processed #{i} cables"