namespace :app do
  desc "Scrape Vendor Site"
  task :scrape_vendor => :environment do
    Scraper.new.scrape_categories
  end
end