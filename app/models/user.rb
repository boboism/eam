class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
  has_many :accepted_assets, :class_name => "Asset", :foreign_key => "accepted_by_id"
  has_many :activated_assets, :class_name => "Asset", :foreign_key => "activated_by_id"
  has_many :created_assets, :class_name => "Asset", :foreign_key => "created_by_id"
  has_many :updated_assets, :class_name => "Asset", :foreign_key => "updated_by_id"
  
end
