# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Course.create!(title: "Quantum Consciousness", category: "Cognitive Science", units:"2-3", days:"TuTh", time:"5PM-6PM"  , status:"open")  
Course.create!(title: "Taiwanese Language", category: "Languages", units:"1-2", days:"MW", time: "5PM-6:30PM", status:"full")  
Course.create!(title: "Python on Crack", category: "Computer Science", units:"3", days:"MWF", time: "6PM-8PM", status:"full")
Course.create!(title: "Ruby on Rails", category: "Computer Science", units:"2", days:"MW", time: "7PM-8PM", status:"full")  
Course.create!(title: "Max Interval Training", category: "Fitness", units:"1",  days:"W", time: "8PM-9PM", status:"open") 
Course.create!(title: "Introduction to Banking", category: "Business", units:"2", days:"TuTh", time: "6PM-7PM", status:"full")  