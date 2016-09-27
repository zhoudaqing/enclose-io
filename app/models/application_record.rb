class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :recent, -> { order(created_at: :desc) }
  scope :hot, -> {order(updated_at: :desc)}
end
