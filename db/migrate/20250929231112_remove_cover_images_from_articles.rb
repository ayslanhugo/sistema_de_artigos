# db/migrate/xxxxxxxx_remove_cover_images_from_articles.rb

class RemoveCoverImagesFromArticles < ActiveRecord::Migration[7.1]
  def change
    # Encontra todos os anexos que são 'cover_image'
    ActiveStorage::Attachment.where(name: 'cover_image').each do |attachment|
      # O método purge apaga o anexo do banco de dados E o arquivo do Cloudinary
      attachment.purge
    end
  end
end
