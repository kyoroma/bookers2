class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
          
         has_many :books, dependent: :destroy
         has_one_attached :profile_image
         attribute :introduction, :string
         validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 20 }
         validates :introduction, presence: true, length: { maximum: 50 }
end