class Leak < ActiveRecord::Base

  searchable do
    text :body
  end


  def self.search(user_search_string)
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

end

