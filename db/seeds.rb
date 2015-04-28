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


course1 = Course.create!(semester: "Spring 2015", title: "A", category: "Computer Science",  units: 1, pending: false, description: 'hi', enrollment_info: 'hi')  
course2 = Course.create!(semester: "Fall 2015", title: "B", category: "Cognitive Science", units: 1, pending: false, description: 'hi', enrollment_info: 'hi') 
course3 = Course.create!(semester: "Spring 2015",title: "C", category: "Computer Science", units: '1-2', pending: false, description: 'hi', enrollment_info: 'hi') 
course4 = Course.create!(semester: "Fall 2015",title: "D", category: "Fitness", units: '1-2', pending: false, description: 'hi', enrollment_info: 'hi') 
course5 = Course.create!(semester: "Spring 2015",title: "E", category: "Business", units: '1-2', pending: false, description: 'hi', enrollment_info: 'hi') 
course6 = Course.create!(semester: "Fall 2015",title: "F", category: "Languages",  units: 1, pending: false, description: 'hi', enrollment_info: 'hi') 
course7 = Course.create!(semester: "Spring 2015",title: "G", category: "Computer Science",units: 1, pending: false, description: 'hi', enrollment_info: 'hi') 
course8 = Course.create!(semester: "Spring 2015",title: "H", category: "Business", units: 1, pending: true, description: 'hi', enrollment_info: 'hi') 
course9 = Course.create!(semester: "Spring 2015",title: "I", category: "Fitness", units: '1-2', pending: true, description: 'hi', enrollment_info: 'hi') 
course10 = Course.create!(semester: "Fall 2015",title: "J", category: "Languages",  units: '1-2', pending: true, description: 'hi', enrollment_info: 'hi') 
course11 = Course.create!(semester: "Fall 2015",title: "K", category: "Computer Science",  units: '1-2', pending: true, description: 'hi', enrollment_info: 'hi') 
course12 = Course.create!(semester: "Spring 2015",title: "L", category: "Computer Science", units: 1, pending: true, description: 'hi', enrollment_info: 'hi') 

FacilitateOwnedcourse.create!(facilitator_id: user6.id, ownedcourse_id: course1.id)





