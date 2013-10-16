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
    SubCategory.create(code: row[0][-2,2],
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
  puts "Initializing SubCategory Number Pooling #{sub_cat.inspect}"
  AssetNumberPooling.arrange_sub_category_number_pooling(sub_cat)
end

#puts "Tax Preference"
#TaxPreference.create(code:'NOTBLN', name:'不属于', enabled: true, created_by_id: 1, updated_by_id: 1)
#TaxPreference.create(code: 'ENGSAV', name: '节能节水设备', enabled: true, created_by_id: 1, updated_by_id: 1)
#TaxPreference.create(code: 'ENVPRO', name:'环境保护设备', enabled: true, created_by_id: 1, updated_by_id: 1)
#TaxPreference.create(code:'RND', name: '研发专用资产', enabled: true, created_by_id: 1, updated_by_id: 1)
#TaxPreference.create(code:'SAVPRD', name: '安全生产设备', enabled: true, created_by_id: 1, updated_by_id: 1)

puts "Construction Period"
ConstructionPeriod.create(code: "PHASE#1", name: "一期", enabled: true, created_by_id: 1, updated_by_id: 1)
ConstructionPeriod.create(code: "PHASE#2", name: "二期", enabled: true, created_by_id: 1, updated_by_id: 1)

puts "Specific Investment"
SpecificInvestment.create(code: "01", name: "通用", enabled: true, created_by_id: 1, updated_by_id: 1)
SpecificInvestment.create(code: "02", name: "AC专用", enabled: true, created_by_id: 1, updated_by_id: 1)
SpecificInvestment.create(code: "03", name: "AD专用", enabled: true, created_by_id: 1, updated_by_id: 1)
SpecificInvestment.create(code: "04", name: "AE专用", enabled: true, created_by_id: 1, updated_by_id: 1)
SpecificInvestment.create(code: "05", name: "AF专用", enabled: true, created_by_id: 1, updated_by_id: 1)
SpecificInvestment.create(code: "02", name: "AH专用", enabled: true, created_by_id: 1, updated_by_id: 1)

puts "Cost Center"
ostCenter.create(code: "1110A", name: "冲压科-直直", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1110C", name: "冲压科-直间", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1120A", name: "焊装科-直直", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1120C", name: "焊装科-直间", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1130A", name: "涂装科-直直", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1130C", name: "涂装科-直间", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1131A", name: "涂装科-车身-直直", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1131C", name: "涂装科-车身-直间", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1132A", name: "涂装科-保险杠-直直", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1132C", name: "涂装科-保险杠-直间", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1140A", name: "总装科-直直", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1140C", name: "总装科-直间", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1150C", name: "制造部综合管理科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1210A", name: "整车品质科-直直", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1210C", name: "整车品质科-直间", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1220S", name: "零件品质科-准直", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1230S", name: "品质技术科-准直", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1240S", name: "品质保证科-准直", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1250S", name: "市场品质科-准直", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1260S", name: "品质企划科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1270S", name: "车体品质科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1310S", name: "生产管理科-准直", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1320S", name: "物流管理科-准直", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1900C", name: "SSC事务局", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1901C", name: "AF派生异地生产项目组", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "1902C", name: "外作设施组", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "2100S", name: "制造2", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "2110A", name: "冲压（公用）", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "2130A", name: "涂装（公用）", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "2150A", name: "冲压（GF）", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "2160A", name: "焊装（GF）", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "2170A", name: "涂装（GF）", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "2180A", name: "总装（GF）", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "2260A", name: "整车品质", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "2340S", name: "物流管理", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "4110C", name: "发动机本部综合管理科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "4111C", name: "发动机本部综合管理科-管理系", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "4112S", name: "发动机本部综合管理科-计划系", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "4113S", name: "发动机本部综合管理科-物流系", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "4210S", name: "发动机品质科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "4211S", name: "发动机品质科零件品质系", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "4212S", name: "发动机品质科品质技术系", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "4215S", name: "发动机品质科市场品质系", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "4220S", name: "发动机生产技术科-准直", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "4230S", name: "发动机产品技术科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "4330C", name: "机械科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "4331A", name: "加工系曲轴组-直直", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "4332A", name: "加工系缸盖组-直直", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "4333A", name: "加工系缸体组-直直", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "4334A", name: "装配系-直直", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "4340S", name: "设备科-准直", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "61100", name: "品牌科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "61200", name: "销售科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "61300", name: "客户服务科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "61400", name: "营销规划科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "61500", name: "零部件科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "61610", name: "华南区", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "61620", name: "华东区", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "61630", name: "华北区", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "61640", name: "西南西北区", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "61650", name: "东北区", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "61660", name: "华中区", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "61670", name: "华南二区", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "61700", name: "市场传播科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "61800", name: "渠道发展科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "61900", name: "营销管理科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "61A00", name: "营销培训中心", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "62200", name: "出口项目组", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "71000", name: "办公室", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "71100", name: "企划科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "71199", name: "GFⅡ项目组", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "71200", name: "文秘接待科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "71300", name: "法务审计监察科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "71400", name: "公共关系科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "72100", name: "人事科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "72199", name: "大学生组", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "72200", name: "总务科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "72300", name: "安全保卫科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "72400", name: "IT科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "73100", name: "会计科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "73200", name: "财务科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "73300", name: "销售财务科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "74100", name: "动力底盘科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "74200", name: "车身科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "74300", name: "综合采购科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "74400", name: "成本企划科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "74500", name: "电子电器科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "75100", name: "发展科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "7520S", name: "设施管理科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "76000", name: "党委工作部", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "77000", name: "工会办公室", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "78000", name: "技术部", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "78100", name: "新车推进科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "78106", name: "新车推进科试制系", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "78200", name: "生产技术科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "78300", name: "规格管理科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "78400", name: "车身工艺科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "78500", name: "新能源科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "81100", name: "产品规划科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "82000", name: "工艺规划室", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "82100", name: "工厂规划科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "82200", name: "车身工艺科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "82300", name: "总装工艺科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "83000", name: "技术管理室", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "83100", name: "项目管理科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "83200", name: "成本工程科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "83300", name: "试验认证科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "84000", name: "整车室", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "84100", name: "产品技术科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "84106", name: "产品技术科试制系", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "84200", name: "新能源科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "84300", name: "技术规格科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "85000", name: "动力总成室", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "85100", name: "动力总成产品技术科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "85200", name: "动力总成品质技术科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "85300", name: "动力总成生产技术科", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "86000", name: "技术支援室", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "88000", name: "能扩事务局", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "88010", name: "宜昌项目组", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "88020", name: "海缝事务组", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "91000", name: "工程部(一)", enabled: true, created_by_id: 1, updated_by_id: 1)
CostCenter.create(code: "99999", name: "部门(通用)", enabled: true, created_by_id: 1, updated_by_id: 1)

puts "Department"

Department.create(code: "11000", name: "制造部", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "12000", name: "质量部", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "13000", name: "生管物流部", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "19000", name: "SSC事务局", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "21000", name: "制造部", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "22000", name: "质量部2", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "23000", name: "生管物流部2", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "41000", name: "发动机本部", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "42000", name: "发动机本部技术质量部", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "43000", name: "发动机本部制造部", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "61000", name: "销售部", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "62000", name: "出口项目组", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "71000", name: "办公室", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "72000", name: "综合管理部", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "73000", name: "财务部", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "74000", name: "采购部", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "75000", name: "工程部", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "76000", name: "党委工作部", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "77000", name: "工会办公室", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "78000", name: "技术部", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "81000", name: "产品规划科", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "82000", name: "工艺规划室", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "83000", name: "技术管理室", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "84000", name: "整车室", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "85000", name: "动力总成室", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "86000", name: "技术支援室", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "88000", name: "GF项目组", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "91000", name: "工程部(一)", enabled: true, created_by_id: 1, updated_by_id: 1)
Department.create(code: "99000", name: "部门(通用)", enabled: true, created_by_id: 1, updated_by_id: 1)

