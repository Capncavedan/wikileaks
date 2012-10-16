class Cable < ActiveRecord::Base

  has_many :comments

  searchable do
    text :header, :body, :origin_id, :destination_id
    string :classification, :origin_description
    time :cable_date

    text :all_comment_text

    integer :cable_year do
      cable_date.try(:year)
    end
  end

  def all_comment_text
    comments.map{ |comment| comment.body }
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

  attr_accessible :cable_date, :origin_id, :origin_description, :classification, :destination_id, :header, :body

end

