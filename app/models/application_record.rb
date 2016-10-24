class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :recent, -> { order(created_at: :desc) }
  scope :old, -> { order(created_at: :asc) }
  scope :hot, -> {order(updated_at: :desc)}
end
