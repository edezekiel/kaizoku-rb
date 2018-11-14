class CommandLineInterface
  def pastel
    pastel = Pastel.new
    pastel
  end

  def separator
    pastel
    puts "                                                      "
    puts pastel.bright_magenta("======================================================")
    puts "                                                      "
  end

  def greet
    pastel
    separator
    puts "Welcome to #{pastel.bright_cyan('Kaizoku')}!"
    puts "                                                      "
    puts "Easily find the best gem for the task at hand."
    puts "Type #{pastel.bright_cyan('Exit')} at any time to quit the app."
  end

  def gets_user_input
    gets.chomp
  end

  def create_category_hash

    doc = Nokogiri::HTML(open("https://www.ruby-toolbox.com"))
    binding.pry
    ## Example scraper from Kickstarter lab

      # html = File.read('fixtures/kickstarter.html')
      # kickstarter = Nokogiri::HTML(html)
      # projects = {}
      #
      # kickstarter.css("li.project.grid_4").each do |project|
      #   title = project.css("h2.bbcard_name strong a").text
      #   projects[title.to_sym] = {
      #     :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      #     :description => project.css("p.bbcard_blurb").text,
      #     :location => project.css("ul.project-meta span.location-name").text,
      #     :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
      #   }
      # end
      # projects
  end

  def create_subcategory_hash
  end

  def create_toolkit_hash
  end

  def run
    greet
    puts "Type #{pastel.bright_cyan('Categories')} to get started."
    separator
    gets_user_input
    create_category_hash
  end
end

  ## Using Nokogiri to get data for Kaizoku

    # * Source - https://www.ruby-toolbox.com/search?utf8=%E2%9C%93&q=pirate
    # * (first) Category group name -  doc.css(".category-group").first.css("h3").text
    #
    # * (first) Subcategory name (from main page) -  doc.css(".column.is-half-desktop").first.css("a span").text
    # * (first) Subcategory url (from main page) -  doc.css(".column.is-half-desktop").first.css("a").attribute("href").value
    #
    # * Subcategory description (once you’ve opened the url) -  doc.css(".container .subtitle").text
    #
    # * (first) Gem name -  doc.css(".is-size-4").first.children.text
    # * (first) Gem score -  doc.css(".score").first.css("span").text
    # * (first) Gem description -  doc.css(".description.column").first.text
    # * (first) Gem Github -  doc.css(".links.column").first.css(".button.is-white")[1].attributes["href"].text
