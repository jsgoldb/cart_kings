require_all 'app'
require 'open-uri'

class Scraper 

  BASE = "http://www.mymadjax.com"
  MAIN_PAGE = "http://www.mymadjax.com/Shop-by-Category/"
  MAIN_PAGE_CAT_DIV = "div.category_cell_div"
  SUB_PAGE_CAT_DIV = "div.category_cell_wide_div"
  MAIN_PAGE_LABEL = "div.category_cell_label"
  SUB_PAGE_LABEL = "div.category_cell_wide_label"

  def scrape_categories(page = MAIN_PAGE, div = MAIN_PAGE_CAT_DIV, label = MAIN_PAGE_LABEL)
    data = Nokogiri::HTML(open(page))
    data.css(div).map do |category_div|
      cat_name = category_div.css(label).text
      unless cat_name == ''
        category = Category.find_or_create_by(name: cat_name)
        category.image = URI.join(BASE, category_div.css("a img").attribute("src").value)
        category.save
        scrape_second_level(category_div, category)
      end
    end
  end

  def scrape_second_level(category_div, category)
    page = "#{URI.join(BASE, category_div.css("a").attribute("href").value)}"
    data = Nokogiri::HTML(open(page))
    if data.at_css('div.category_item_cell_div')
      scrape_part(data, category)
    elsif data.at_css(SUB_PAGE_CAT_DIV)
      data.css(SUB_PAGE_CAT_DIV).map do |category_div|
        subcat = Category.find_or_create_by(name: category_div.css("a").attribute("title").value)
        subcat.image = URI.join(BASE, category_div.css("a img").attribute("src").value)
        if !subcat.save
          binding.pry
        end
        category.child_categories << subcat
        category.save
      end
      scrape_categories(page, SUB_PAGE_CAT_DIV, SUB_PAGE_LABEL)
    end
  end

  def scrape_part(data, category)
    data.css('div.category_item_cell_div').map do |part_div|
      part_desc = part_div.css("center").text
      part = Part.find_or_create_by(description: part_desc)
      if part.description == "MIRAGE 14x7 Black w/ 205/30/14 Viper Street Tire"
      end
      image_url = part_div.css("a img").attribute("src").value
      part.image = URI.encode(BASE + image_url)
      part.category = category
      part.price = part_div.css("span")[1].text.split(" ").last.to_d
      if !part.save
      end
    end
  end

end