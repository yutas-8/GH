class Thank < ApplicationRecord
  belongs_to :from, class_name: "member"
  belongs_to :to, class_name: "member"
end
