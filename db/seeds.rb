# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Course.create!(title: "Quantum Consciousness", category: "Cognitive Science", units:"2", status:"Open")  
Course.create!(title: "Taiwanese Language", category: "Languages", units:"1", status:"Full")  
Course.create!(title: "Python on Crack", category: "Computer Science", units:"3", status:"Full")
Course.create!(title: "Ruby on Rails", category: "Computer Science", units:"2", status:"Full")  
Course.create!(title: "Max Interval Training", category: "Fitness", units:"1", status:"Open") 
Course.create!(title: "Introduction to Banking", category: "Business", units:"2", status:"Full")
