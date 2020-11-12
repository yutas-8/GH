class Thank < ApplicationRecord
  belongs_to :from, class_name: "Member"
  belongs_to :to, class_name: "Member"
end
