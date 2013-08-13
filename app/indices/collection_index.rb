ThinkingSphinx::Index.define :collection, :with => :active_record do
  indexes title, :sortable => true
end