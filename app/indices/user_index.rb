ThinkingSphinx::Index.define :user, :with => :active_record do
  indexes name
  indexes :items_count, :sortable => true
  indexes :shop
  indexes :followers_counter, :sortable => true
end