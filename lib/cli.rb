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

  def exit_screen
    puts "Thank you for using Kaizoku!"
    separator
    exit
  end

  def unrecognized_input
    puts "Input not recognized."
    exit_screen
  end

  def greeting_screen
    separator
    puts "Welcome to #{pastel.bright_cyan('Kaizoku')}!"
    puts "                                                      "
    puts "Easily find the best gem for the task at hand."
    puts "Type #{pastel.bright_cyan('list')} to see a list of gem categories."
    separator
    get_category_screen
  end

  def get_category_validation
    input = gets.chomp
    separator
    if input == "list"
      get_category
    elsif input == "exit"
      exit_screen
    else
      unrecognized_input
    end
  end

  def get_category
    doc = Nokogiri::HTML(open("https://www.ruby-toolbox.com"))
    doc.css(".category-group").each do |category|
      puts category.css("h3").text
    end
    get_subcategory_screen
  end

  def get_category_screen
    get_category_validation
  end

  def get_subcategory
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
          get_gem_screen
        end
      end
    end
  end

  def get_subcategory_screen
    puts "Type the category name to see gem subcategories."
    get_subcategory
  end

  def gem_description
    separator
    input = gets.chomp
    separator
    url = "https://www.ruby-toolbox.com" + @subcategory.css("a").attribute("href").value
    doc = Nokogiri::HTML(open(url))
    doc
  end

  def gem_description_output(doc)
    puts "Here's the gem for the job!"
    puts "  "
    puts "name: " + doc.css(".is-size-4").first.children.text
    puts "score: " + doc.css(".score").first.css("span").text
    puts "description: " + doc.css(".description.column").first.text
    puts "github: " + doc.css(".links.column").first.css(".button.is-white")[1].attributes["href"].text
    exit_screen
  end

  def get_gem_screen
    puts "Type the subcategory to see the best gem for that category."
    doc = gem_description
    gem_description_output(doc)
  end

  def run
    greeting_screen
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
