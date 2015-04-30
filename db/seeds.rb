# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Test Courses
# Course.create!(title: "Taiwanese Language", category: "Languages", units:"1", status:"Full")
# Course.create!(title: "Python on Crack", category: "Computer Science", units:"3", status:"Full")
# Course.create!(title: "Ruby on Rails", category: "Computer Science", units:"2", status:"Full")
# Course.create!(title: "Max Interval Training", category: "Fitness", units:"1", status:"Open")
# Course.create!(title: "Introduction to Banking", category: "Business", units:"2", status:"Full")
#Test Users

user1 = User.create!(:email => "jamescheng@berkeley.edu", :password => "jalapenocheddar",
 	:first_name => "James", :last_name => "Cheng")
user2 = User.create!(email: "johnlennon@berkeley.edu", password: "thebeatlesforever",
 	first_name: "John", last_name: "Lennon")
user3 = User.create!(email: "jetspike@berkeley.edu", password: "cowboybebop",
 	first_name: "Jet", last_name: "Spike")
user4 = User.create!(email: "vashthestampede@berkeley.edu", password: "trigunseed",
 	first_name: "Vash", last_name: "Stampede")
user5 = User.create!(email: "mugenjin@berkeley.edu", password: "samuraichamploo",
 	first_name: "Mugen", last_name: "Jin")
user6 = User.create!(email: "master@berkeley.edu", password: "123456789",
 	first_name: "Himura", last_name: "Kenshin")

Category.create!(name: "Computer Science")
Category.create!(name: "Fitness")
Category.create!(name: "Business")
Category.create!(name: "Languages")
Category.create!(name: "Cognitive Science")

Semester.create!(name: "Spring 2015")
Semester.create!(name: "Fall 2015")


course1 = Course.create!(semester: "Spring 2015", title: "C", category: "Computer Science",  units: 1, pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi")  
course2 = Course.create!(semester: "Fall 2015", title: "B", category: "Cognitive Science", units: 1, pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi") 
course3 = Course.create!(semester: "Spring 2015",title: "A", category: "Computer Science", units: '1-2', pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi") 
course4 = Course.create!(semester: "Fall 2015",title: "F", category: "Fitness", units: '1-2', pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi") 
course5 = Course.create!(semester: "Spring 2015",title: "E", category: "Business", units: '1-2', pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi") 
course6 = Course.create!(semester: "Fall 2015",title: "D", category: "Languages",  units: 1, pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi") 
course7 = Course.create!(semester: "Spring 2015",title: "G", category: "Computer Science",units: 1, pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi") 
course8 = Course.create!(semester: "Spring 2015",title: "H", category: "Business", units: 1, pending: true, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi") 
course9 = Course.create!(semester: "Spring 2015",title: "I", category: "Fitness", units: '1-2', pending: true, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi") 
course10 = Course.create!(semester: "Fall 2015",title: "L", category: "Languages",  units: '1-2', pending: true, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi") 
course11 = Course.create!(semester: "Fall 2015",title: "K", category: "Computer Science",  units: '1-2', pending: true, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi") 
course12 = Course.create!(semester: "Spring 2015",title: "J", category: "Computer Science", units: 1, pending: true, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi") 

section1 = Section.new(section_title: "1", days: "TuTh", status: "Open", start_time: Section.time_to_int("8:00AM"), end_time: Section.time_to_int("9:00AM"), location: "186 Barrows")
section1.course = course1
section1.save

section2 = Section.new(section_title: "2", days: "MWF", status: "Full", start_time: Section.time_to_int("9:00AM"), end_time: Section.time_to_int("10:00AM"), location: "186 Barrows")
section2.course = course2
section2.save

section3 = Section.new(section_title: "3", days: "ThF", status: "Full", start_time: Section.time_to_int("10:00AM"), end_time: Section.time_to_int("11:00AM"), location: "186 Barrows")
section3.course = course1
section3.save

section4 = Section.new(section_title: "4", days: "MTu", status: "Started", start_time: Section.time_to_int("11:30AM"), end_time: Section.time_to_int("12:30PM"), location: "186 Barrows")
section4.course = course3
section4.save

section5 = Section.new(section_title: "5", days: "F", status: "Started", start_time: Section.time_to_int("1:00PM"), end_time: Section.time_to_int("2:00PM"), location: "186 Barrows")
section5.course = course4
section5.save

section6 = Section.new(section_title: "6", days: "TuTh", status: "Open", start_time: Section.time_to_int("3:00PM"), end_time: Section.time_to_int("4:00PM"), location: "186 Barrows")
section6.course = course5
section6.save

section7 = Section.new(section_title: "7", days: "M", status: "Full", start_time: Section.time_to_int("5:00PM"), end_time: Section.time_to_int("6:30PM"), location: "186 Barrows")
section7.course = course4
section7.save

FacilitateOwnedcourse.create!(facilitator_id: user6.id, ownedcourse_id: course1.id)





