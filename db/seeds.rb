# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


c1 = Cat.create!(name: "Harold", color: "tabby", sex: "M", age: "26", birthdate: "19880211" )
c2 = Cat.create!(name: "Garfield", color: "tabby", sex: "M", age: "1000", birthdate: "18880211" )
c3 = Cat.create!(name: "Jumbo", color: "solid", sex: "M", age: "2", birthdate: "19681230" )
c4 = Cat.create!(name: "Patty", color: "calico", sex: "F", age: "13", birthdate: "19940211" )
c5 = Cat.create!(name: "Bobobob", color: "tabby", sex: "M", age: "1", birthdate: "19750211" )

r1 = CatRentalRequest.create!(cat_id: c1.id, start_date: "2014-01-01", end_date: "2014-01-02")
r1 = CatRentalRequest.create!(cat_id: c2.id, start_date: "2014-02-02", end_date: "2014-02-05")
r1 = CatRentalRequest.create!(cat_id: c2.id, start_date: "2014-03-01", end_date: "2017-03-01")
r1 = CatRentalRequest.create!(cat_id: c5.id, start_date: "2014-01-01", end_date: "2014-01-02")
r1 = CatRentalRequest.create!(cat_id: c5.id, start_date: "2014-01-05", end_date: "2014-01-06")