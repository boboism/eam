RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.secret_key = '731270805ec2f52803b6b8cd7a0d7d64d366965c5fe22f60be7768a4b69f10a8e935fb73e57ee12b6637e3d205f156264cb1cf345da49910b3b518cbab101fa5'
end
