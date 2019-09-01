class Recipe < ApplicationRecord
  belongs_to :recipe_type	
  belongs_to :user
  has_many :menus
  has_many :list_recipes, through: :menus

  enum status: { pending: 0 , approved: 12, rejected:22 }

  validates :title, presence: true, length: {minimum: 12 }, format: {with: /\A[a-zA-Z]\s?/, message: "only allows letters and must contain spaces"}
  validates :recipe_type_id, presence: true
  validates :cuisine, presence: true 
  validates :difficulty, presence: true, length: {minimum: 5 }
  validates :ingredients, presence: true, length: {minimum: 20 }
  validates :cook_method, presence: true, length: {minimum: 20 }
  validates :cook_time, presence: true, numericality: {only_integer: true}, format: {with: /\d/, message: "Only integer"}
  validates_inclusion_of :cook_time, in: 2..200

  def cook_time_min
    "#{cook_time} minutos"
  end

  def owner?(user)
  	self.user == user  	
  end
end
