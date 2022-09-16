# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts 'Seeding development database...'
dean = User.find_or_create_by!(email: 'dean@example.com') do |user|
                             user.password = 'password'
                             user.password_confirmation = 'password'
                             user.first_name = 'Dean'
                             user.last_name = 'DeHart'
                             user.role = User.roles[:admin]
                            end

john = User.find_or_create_by!(email: 'john@doe.com') do |user|
                             user.password = 'password'
                             user.password_confirmation = 'password'
                             user.first_name = 'John'
                             user.last_name = 'Doe'
                            end
Address.find_or_create_by!(user: dean) do |address|
                              address.street = '123 Main St'
                              address.city = 'Anytown'
                              address.state = 'CA'
                              address.zip = '12345'
                              address.country = 'USA'
                            end
Address.find_or_create_by!(user: john) do |address|
                              address.street = '123 Main St'
                              address.city = 'Anytown'
                              address.state = 'CA'
                              address.zip = '12345'
                              address.country = 'USA'
                            end

elapsed = Benchmark.measure do
  posts = []
  10.times do |x|
    puts "Creating post #{x}"
    post = Post.new(title: "Title #{x}",
                    body: "Body #{x} Words go here Idk",
                    user: dean)

    5.times do |y|
      puts "Creating comment #{y} for post #{x}"
      post.comments.build(body: "Comment #{y}",
                          user: john)
    end
    posts.push(post)
  end
  Post.import(posts, recursive: true)

  # contacts
  contacts = []
  50.times do |x|
    puts "Creating contacts #{x}"
    contact = Contact.new(name: FFaker::Name.name, 
                          email: FFaker::Internet.email, 
                          role: Contact.roles.keys.sample)

    contacts.push(contact)
  end

  Contact.import(contacts)

  # publications
  publications = []

  5.times do |x|
    puts "Creating publications #{x}"
    contact = Contact.publishers.sample
    publication_params = {name: FFaker::Name.name, contact_name: contact.name, contact_email: contact.email}

    publication = contact.publications.create!(name: publication_params[:name])

  end
end

puts "Seeded development DB in #{elapsed.real} seconds"
