class Project < ApplicationRecord

  enum project_type: %i[public_type private_type]

  has_one_attached :logo

  belongs_to :user

  validates :name, :project_type, :description, :logo, presence: true
  validates :name, uniqueness: { scope: :user_id }

end
