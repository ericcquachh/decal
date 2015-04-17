class User < ActiveRecord::Base

  validates :email,
  presence: true,
  uniqueness: true,
  format: {

    message: 'domain must be berkeley.edu',
    with: /\A[\w+-.]+@berkeley.edu\z/i
  }

  #facilitator relation
  # has_many :courses, :foreign_key => :uid
  has_many :courses_users
  has_many :courses, through: :courses_users
  # Include default devise modules. Others available are:

  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
  :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  #access = ["student", "facilitator", "admin"]
  attr_accessible :email, :last_name, :first_name, :class_level, :access, :facilitator, :admin, :course_id,
  #devise defaults
  :password, :password_confirmation, :remember_me, :provider, :uid, :propic
  # attr_accessible :title, :body

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(
        access: "student",
        provider:access_token.provider,
        email: data["email"],
        admin: false,
        facilitator: false,
        uid: access_token.uid ,
        first_name: data["first_name"],
        last_name: data["last_name"],
        password: Devise.friendly_token[0,20],
        )
      end
    end
  end

  def self.access
    ["student", "facilitator", "admin"]
  end
end
