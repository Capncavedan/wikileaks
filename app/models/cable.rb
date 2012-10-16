class Cable < ActiveRecord::Base

  attr_accessible :cable_date, :origin_id, :origin_description, :classification, :destination_id, :header, :body

  searchable do
    text :header
    text :body
    text :origin_id
    text :destination_id

    string :classification
    string :origin_description

    time :cable_date

    integer :cable_year
  end

  def cable_year
    cable_date.try(:year)
  end

  def self.sql_search(user_search_string)
    conditions = []
    user_search_string.split(' ').each do |term|
      conditions << sanitize_sql_array(["body LIKE ?", "%#{term}%"])
    end
    find :all,
      conditions: conditions.join(' AND '),
      order: 'id DESC',
      limit: 50
  end
  # produces SQL WHERE clause like so:
  # (body LIKE '%Rupert%' AND body LIKE '%Murdoch%' AND \
  #  body LIKE '%Montgomery%' AND body LIKE '%Burns%')


  def self.origin_options
    uniq.pluck(:origin_description).sort
  end

end

