class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :due_date, presence: true

  VALID_STATUSES = ["pending", "completed"]

  validates :status, inclusion: { in: VALID_STATUSES }

  validate :due_date_is_future_date

  def is_pending?
    status == "pending"
  end

  def self.ransackable_attributes(auth_object = nil)
    ["status", "title", "status", "due_date"]
  end

  # this method allow to sort the tasks (Rails recommendation).
  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  private

  def due_date_is_future_date
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "Due date must be a future date")
    end
  end
end
