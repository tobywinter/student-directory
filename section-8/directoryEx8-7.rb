@students = [] #an empty array accessibly to all methods (instance variable?)
@letter = ""

def my_puts(str)
  puts str.center(100)
end

def input_students
  my_puts "Please enter the names of the students".center(20)
  my_puts "To finish, just hit return twice".center(20)
  #get the first name
  name = STDIN.gets.chomp
  if !name.empty?
    my_puts "Cohort"
    cohort = STDIN.gets.chomp.capitalize.to_sym
    my_puts "Enter students age"
    age = STDIN.gets.chomp
    my_puts "Enter students country of birth"
    countryofbirth = STDIN.gets.chomp
  end
  #while the name is not empty, repeat this code
  while !name.empty? do
    #add the student hash to the array
    @students << {name: name, cohort: cohort, age: age, countryofbirth: countryofbirth}
    my_puts "Now we have #{@students.count} students".center(20)
    #get another name from the user
#Allows entry of multiple elements BUT asks for all even if name not entered -FIX
    my_puts "Students name"
    name = STDIN.gets.chomp
    if !name.empty?
      my_puts "Enter students age"
      age = STDIN.gets.chomp
      my_puts "Enter students country of birth"
      countryofbirth = STDIN.gets.chomp
    end
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
  my_puts "Student list saved"
end

def load_students (filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
      @students << {name: name, cohort: cohort.to_sym}
    end
    my_puts "Loaded #{@students.count} from #{filename}"
    file.close
end

def try_load_students
  filename = ARGV.first #first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) #if it exists
    load_students(filename)
    my_puts "Loaded #{@students.count} from #{filename}"
  else #if it doesn't exist
    my_puts "Sorry, #{filename} doesn't exist."
    exit #quit the program
  end
end

def print_students_alpha
  @students_alpha = @students.select {|student| (student[:name][0]) == (@letter.upcase)}
  @students_alpha.each do |student|
    my_puts "#{@students_alpha.find_index(student)+1}. #{student[:name]} (#{student[:cohort]} cohort) Age:#{student[:age]} #{student[:countryofbirth]}"
  end
end

def print_header_alpha
  my_puts "The students of Villains Academy A-Z - #{@letter.upcase}"
  my_puts "------------"
end

def print_footer_alpha
  my_puts "We have #{@students_alpha.count} beginning with #{@letter.upcase}"
end

def print_header
  my_puts "The students of Villains Academy"
  my_puts "------------"
end

def print_students_list
  index = 0
  until index == @students.length
    my_puts "#{index+1}.#{@students[index][:name]} (#{@students[index][:cohort]} cohort) Age:#{@students[index][:age]}, #{@students[index][:countryofbirth]}\n"
    index += 1
  end
end

def print_footer
  my_puts "Overall, we have #{@students.count} great students"
end

def print_menu
  my_puts "1. Input the students"
  my_puts "2. Show the students"
  my_puts "3. Save the lists to students.csv"
  my_puts "4. Load the list from students.csv"
  my_puts "5. Show students with names that begin with a specific letter"
  my_puts "6. Show students with names less that 12 characters long"
  my_puts "9. Exit" #9 because we'll add more items inbetween
end

def show_students
  print_header
  print_students_list
  print_footer
end

def show_students_alpha
  my_puts "Please select a letter to sort for:"
  @letter = STDIN.gets.chomp
  print_header_alpha
  print_students_alpha
  print_footer_alpha
end

def print_students_short
  @students_short = @students.select {|student| (student[:name].length) < 12}
  @students_short.each do |student|
    my_puts "#{@students_short.find_index(student)+1}. #{student[:name]} (#{student[:cohort]} cohort) Age:#{student[:age]} #{student[:countryofbirth]}"
  end
end

def print_footer_alpha
  my_puts "We have #{@students_short.count} with names less that 12 characters."
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
      my_puts "I don't know what you mean, try again"
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
