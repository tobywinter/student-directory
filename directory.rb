#first we print the list of students
puts "The students of Villains Academy"
students = [
  "Dr. Hannibal Lecter",
  "Darth Vader",
  "Nurse Ratched",
  "Michael Corleone",
  "Alex DeLarge",
  "The Wicked Witch of the West",
  "Terminator",
  "Freddy Krueger",
  "The Joker",
  "Joffrey Baratheon",
  "Norman Bates"
]
# and then print them
puts "------------"
students.each do |student|
  puts student
end
#finally, we print the total number of students
print "Overall, we have #{students.count} great students"
