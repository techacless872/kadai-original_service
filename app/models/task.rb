class Task < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 255 }
  validates :status, presence: true, length: { maximum: 10 }
  validates :subject, presence: true, length: { maximum: 50 }
  
  has_many :task_permissions, dependent: :destroy
  has_many :users, through: :task_permissions
  

end
