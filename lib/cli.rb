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

  def greeting_screen
    puts "Welcome to #{pastel.bright_cyan('Kaizoku')}!"
    puts "                                                      "
    puts "Easily find the best gem for the task at hand."
    puts "Type #{pastel.bright_cyan('Exit')} at any time to quit the app."
    puts "Type #{pastel.bright_cyan('list')} to see a list of gem categories."
    separator
    gets.chomp
  end

  def get_category_screen
    doc = Nokogiri::HTML(open("https://www.ruby-toolbox.com"))
    doc.css(".category-group").each do |category|
      puts category.css("h3").text
    end
    get_subcategory_screen
  end

  def get_subcategory_screen
    puts "Type the category name to see gem subcategories."
    separator
    input = gets.chomp
    separator
    doc = Nokogiri::HTML(open("https://www.ruby-toolbox.com"))
    doc.css(".category-group").each do |category|
      category.css(".column.is-half-desktop").each do |subcategory|
        if category.css("h3").text == input
          @category = category
          @subcategory = subcategory
          puts subcategory.css("a span").text
        end
      end
    end
    get_toolkit_screen
  end

  def get_toolkit_screen
    puts "Type the subcategory to see the best gem for that category!"
    separator
    input = gets.chomp
    url = "https://www.ruby-toolbox.com" + @subcategory.css("a").attribute("href").value
    doc = Nokogiri::HTML(open(url))

    gem_name = doc.css(".is-size-4").first.children.text
    gem_score = doc.css(".score").first.css("span").text
    gem_description = doc.css(".description.column").first.text
    gem_github = doc.css(".links.column").first.css(".button.is-white")[1].attributes["href"].text

    puts "Here's the gem for the job!"
    separator
    puts "name" + " " + gem_name
    puts "score" + " " + gem_score
    puts "description" + " " + gem_description
    puts "github" + " " + gem_github
  end

  def run
    separator
    greeting_screen
    separator
    get_category_screen
    separator
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
