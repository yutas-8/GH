class Thank < ApplicationRecord
  belongs_to :from, class_name: "Member"
  belongs_to :to, class_name: "Member"
  validates :to_id, presence: true
  validate :cannot_send_it_to_myseif
  validates :body, presence: true

  def cannot_send_it_to_myseif
    if from_id == to_id
      errors.add(:from_id, "には贈れない")
    end
  end
end
