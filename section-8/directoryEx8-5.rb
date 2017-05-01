@students = [] #an empty array accessibly to all methods (instance variable?)
@letter = ""

def input_students
  puts "Please enter the names of the students".center(20)
  puts "To finish, just hit return twice".center(20)
  #get the first name
  name = STDIN.gets.chomp
  puts "Enter students age"
  age = STDIN.gets.chomp
  puts "Enter students country of birth"
  countryofbirth = STDIN.gets.chomp
  #while the name is not empty, repeat this code
  while !name.empty? do
    #add the student hash to the array
    @students << {name: name, cohort: :November, age: age, countryofbirth: countryofbirth, }
    puts "Now we have #{@students.count} students".center(20)
    #get another name from the user
    name = STDIN.gets.chomp
  end
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
  puts "Student list saved".center(20)
end

def load_students (filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
      @students << {name: name, cohort: cohort.to_sym}
    end
    puts "Loaded #{@students.count} from #{filename}".center(20)
    file.close
end

def try_load_students
  filename = ARGV.first #first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) #if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}".center(20)
  else #if it doesn't exist
    puts "Sorry, #{filename} doesn't exist.".center(20)
    exit #quit the program
  end
end

def print_students_alpha
  @students_alpha = @students.select {|student| (student[:name][0]) == (@letter.upcase)}
  @students_alpha.each do |student|
    puts "#{@students_alpha.find_index(student)+1}. #{student[:name]} (#{student[:cohort]} cohort)".center(20)
  end
end

def print_header_alpha
  puts "The students of Villains Academy A-Z - #{@letter.upcase}".center(20)
  puts "------------"
end

def print_footer_alpha
  puts "We have #{@students_alpha.count} beginning with #{@letter.upcase}".center(20)
end

def print_header
  puts "The students of Villains Academy"
  puts "------------"
end

def print_students_list
  index = 0
  until index == @students.length
    print "#{index+1}.#{@students[index][:name]} (#{@students[index][:cohort]} cohort)\n".center(20)
    index += 1
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(20)
end

def print_menu
  puts "1. Input the students".
  puts "2. Show the students"
  puts "3. Save the lists to students.csv"
  puts "4. Load the list from students.csv"
  puts "5. Show students with names that begin with a specific letter"
  puts "6. Show students with names less that 12 characters long"
  puts "9. Exit" #9 because we'll add more items inbetween
end

def show_students
  print_header
  print_students_list
  print_footer
end

def show_students_alpha
  puts "Please select a letter to sort for:".center(20)
  @letter = STDIN.gets.chomp
  print_header_alpha
  print_students_alpha
  print_footer_alpha
end

def print_students_short
  @students_short = @students.select {|student| (student[:name].length) < 12}
  @students_short.each do |student|
    puts "#{@students_short.find_index(student)+1}. #{student[:name]} (#{student[:cohort]} cohort)".center(20)
  end
end

def print_footer_alpha
  puts "We have #{@students_short.count} with names less that 12 characters.".center(20)
end

def show_students_short
  print_header
  print_students_short
  print_footer_alpha
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "5"
      show_students_alpha
    when "6"
      show_students_short
    when "9"
      exit
    else
      puts "I don't know what you mean, try again".center(20)
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end


#nothing happens until we call the methods
try_load_students
interactive_menu
