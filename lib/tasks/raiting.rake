namespace :raiting do
  task :flush => :environment do
    Item.raiting_flush
  end
end
