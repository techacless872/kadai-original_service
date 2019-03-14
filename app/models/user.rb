class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :tasks
  has_many :task_permissions, dependent: :destroy
  has_many :selected_tasks, through: :task_permissions, source: :task

  def feed_tasks
    Task.where(user_id: self.selected_tasks_ids + [self.id])
  end

  def select(task)
      self.task_permissions.find_or_create_by(task_id: task.id)
  end
  
  def deselect(task)
    task_permissions = self.task_permissions.find_by(task_id: task.id)
    task_permissions.destroy if task_permissions
  end

  def selected?(task)
    self.selected_tasks.include?(task)
  end
  
  def created?(task)
    self.tasks.include?(task)
  end

end
