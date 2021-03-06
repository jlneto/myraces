# == Schema Information
#
# Table name: strategies
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  layout_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_strategies_on_layout_id  (layout_id)
#  index_strategies_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (layout_id => layouts.id)
#  fk_rails_...  (user_id => users.id)
#
class Strategy < ApplicationRecord
  belongs_to :layout
  belongs_to :user
  has_many :points, dependent: :destroy

  def image_notes
    ret = []
    points.each do |point|
      coords = point.coordinates.split(",")
      ret << {x: coords[0], y: coords[1], note: point.description}
    end
    ret
  end

  def save_points(image_notes)
    points.destroy_all
    image_notes.each do |note|
      add_point_from_note(note[1])
    end
  end

  def add_point_from_note(note)
    point = points.new
    point.coordinates = "#{note["x"]},#{note["y"]}"
    point.description = note["note"]
    point.save!
  end
end
