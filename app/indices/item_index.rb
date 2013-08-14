ThinkingSphinx::Index.define :item, :with => :active_record do
  indexes name
  indexes :raiting, :sortable => true
end