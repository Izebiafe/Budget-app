class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :categories
  has_many :purchases

  attribute :name, :string

  validates :name, presence: true
end
