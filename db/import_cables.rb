require 'rubygems'
require 'american_date'
require 'csv'

# adjust size of data read to fit your needs - 
# 10 MB is about 1370 cables; 100 MB is about 16,500 cables
data = File.read("/Users/danb/Downloads/cables.csv", 100 * 1024 *1024)
Cable.delete_all
i = 1

data.scan(/("\d+","\d{1,2}\/\d{1,2}\/\d{4} \d{1,2}:\d\d",.*?"\n)/m) do |record|
  cable = String.new(record.first.chomp).force_encoding('utf-8')
  cable.gsub!(/\\"/, '""')   # CSV does not like double quotes escaped like so: \"
  cable.gsub!(/\\'/, "'")    # CSV does not like single quotes escaped like so: \'

  # "1","12/28/1966 18:48","66BUENOSAIRES2481","Embassy Buenos Aires","UNCLASSIFIED","66STATE106206","P R 281848Z DEC 66...
  # "2","2/25/1972 9:30","72TEHRAN1164","Embassy Tehran","UNCLASSIFIED","72MOSCOW1603|72TEHRAN1091|72TEHRAN263","R 250930Z FEB 72...
  CSV.parse(cable) do |row|
    numeric_id, cable_date, origin_id, origin_description, classification, destination_id, header, body = row
    puts "#{numeric_id} :: #{origin_id}"
    i += 1

    Cable.create(
      cable_date:         DateTime.parse(cable_date),
      origin_id:          origin_id,
      origin_description: origin_description,
      classification:     classification,
      destination_id:     destination_id.gsub(/\|/, ' '),
      header:             header,
      body:               body)
  end
end

Sunspot.commit

puts "Processed #{i} cables"