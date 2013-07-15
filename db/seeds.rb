#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.com/rails-environment-variables.html

require 'active_support/core_ext'
require 'spreadsheet'
require 'csv'

puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name
user.confirm!
user.add_role :admin


puts 'CACTEGORY'
Category.all.each(&:destroy)
SubCategory.all.each(&:destroy)

CSV.foreach("./db/asset_category.csv") do |row|
  if row[0].size == 1
    Category.create(code: row[0],
                    name: row[1].gsub(/\s*$/,''), 
                    enabled: true, 
                    profiles: {salvage_rate: row[2].to_f, 
                               depreciation_life: row[4].to_f, 
                               inv_verify_percent: row[5].to_f})
  else
    SubCategory.create(code: row[0],
                       name: row[1].gsub(/\s*$/,''), 
                       enabled: true, 
                       profiles: {salvage_rate: row[2].to_f, 
                                  depreciation_life: row[4].to_f, 
                                  inv_verify_percent: row[5].to_f}, 
                       parent_id: Category.where(code: row[6]).first.try(:id))
  end

end
puts "Arranging Number Pooling"
SubCategory.all.each do |sub_cat|
  AssetNumberPooling.arrange_sub_category_number_pooling(sub_cat)
end

puts "Tax Preference"
TaxPreference.create(code:'NOTBLN', name:'不属于', enabled: true, created_by_id: 1, updated_by_id: 1)
TaxPreference.create(code: 'ENGSAV', name: '节能节水设备', enabled: true, created_by_id: 1, updated_by_id: 1)
TaxPreference.create(code: 'ENVPRO', name:'环境保护设备', enabled: true, created_by_id: 1, updated_by_id: 1)
TaxPreference.create(code:'RND', name: '研发专用资产', enabled: true, created_by_id: 1, updated_by_id: 1)
TaxPreference.create(code:'SAVPRD', name: '安全生产设备', enabled: true, created_by_id: 1, updated_by_id: 1)

puts "Construction Period"
ConstructionPeriod.create(code: "PHASE#1", name: "一期", enabled: true, created_by_id: 1, updated_by_id: 1)
ConstructionPeriod.create(code: "PHASE#2", name: "二期", enabled: true, created_by_id: 1, updated_by_id: 1)
