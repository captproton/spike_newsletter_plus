# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# 👋 Also, seeds in Bullet Train are slightly different than vanilla Rails.
# See `docs/seeds.md` for details.

# run seed file based on environment
puts "🌱 Generating global seeds."
load(Rails.root.join('db', 'seeds', "#{Rails.env.downcase}.rb"))