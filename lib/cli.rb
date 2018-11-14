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
    puts "Type #{pastel.bright_cyan('exit')} at any time to quit the app."
  end

  def gets_user_input
    gets.chomp
  end

  def run
    greet

  end
end
