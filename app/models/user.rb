class User < ApplicationRecord
  has_one :wallet, dependent: :destroy
  has_many :portfolios, dependent: :destroy
  has_many :history, dependent: :destroy

  after_create :send_welcome_email, :create_user_wallet
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true
  validates :full_name, presence: true

  # override methods for user approved col
  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    approved? ? super : :not_approved
  end

  private

  def send_welcome_email
    WelcomeMailer.welome_account_email(email).deliver_now
  end

  def create_user_wallet
    user_wallet = Wallet.new(user_id: id, balance: 100_000)
    user_wallet.save
  end
end
