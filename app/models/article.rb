class Article < ApplicationRecord
  belongs_to :user

  # 0 = pendente, 1 = aprovado, 2 = reprovado
  enum :status, [ :pendente, :aprovado, :reprovado ]

  has_one_attached :pdf_file
  has_one_attached :cover_image
end
