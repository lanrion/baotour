# encoding: UTF-8
class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  :lockable
  #:timeoutable and :omniauthable
  devise :database_authenticatable,
         :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :approved, :group
  
  validates :email, :name, :presence => true
  validates :password, :confirmation => true, :if => :new_record?
  validates :password, :password_confirmation, :presence=> true, :if => :new_record?
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :name, :uniqueness => true
  
  attr_accessor :group, :password_confirmation
  
  has_many :manage_hotels
  
  #判断是否存在
  def check_mhotel(hotel_id)
  	ManageHotel.where(:user_id => id.to_i, :hotel_id => hotel_id.to_i).first
  end

  def password_required? 
    new_record?
  end
    
  def show_role
    if has_role? :admin
      return '管理组'
    end
    
    if has_role? :account
      return '财务组'
    end
    
    if has_role? :operator
      return '计调组'
    end
  end
  
  def show_approved
    if !approved?
      '禁用'
    else
      '可用'
    end
  end
  
  def active_for_authentication? 
    super && approved? 
  end
  
  def inactive_message 
    if !approved?
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end
  
  def self.groups
    [RoleEnum.new('计调组',:operator),RoleEnum.new('财务组',:account),RoleEnum.new('管理组',:admin)]
  end
  
  #授权

end
