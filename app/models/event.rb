class Event < ApplicationRecord
  belongs_to :admin, class_name: "User"
  has_many :attendances, dependent: :destroy 
  has_many :users, through: :attendances

  validates :start_after_today,
  presence:true

  validates :duration_modulo_5,
  presence:true

  validates :title,
  presence:true,
  length: { in: 5..140 }

  validates :description,
  presence:true,
  length: { in: 20..1000 }

  validates :price,
  presence:true,
  numericality: { greater_than: 1, less_than: 1000}

  validates :location,
  presence:true

  private

  def start_after_today
    errors.add(:start_date, "ne peut etre créé dans le passé") unless
      start_date.present? && start_date > Date.today
  end 

  def duration_modulo_5
    errors.add(:duration, "doit etre positif et un multiple de 5") unless
      duration%5 == 0 && duration > 0
  end  
end