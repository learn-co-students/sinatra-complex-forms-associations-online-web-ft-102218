# Add seed data here. Seed your database with `rake db:seed`
sophie = Owner.create(name: "Sophie")
kody = Owner.create(name: "Kody")
Pet.create(name: "Maddy", owner: sophie)
Pet.create(name: "Nona", owner: sophie)
Pet.create(name: "Alfred", owner: kody)
Pet.create(name: "Rizza", owner: kody)