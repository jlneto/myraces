# == Schema Information
#
# Table name: tracks
#
#  id         :bigint           not null, primary key
#  location   :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Track < ApplicationRecord
  has_many :layouts, dependent: :destroy

  def add_layout(name, images)
    images.each do |image|
      name = image.original_filename.split(".")[0]
      layout = layouts.find_by_name(name)
      unless layout
        layout = layouts.new
        layout.name = name
      end
      layout.image.attach(image)
      layout.save!
    end
    images
  end
end
