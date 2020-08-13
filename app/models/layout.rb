# == Schema Information
#
# Table name: layouts
#
#  id         :bigint           not null, primary key
#  difficulty :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  track_id   :bigint           not null
#
# Indexes
#
#  index_layouts_on_track_id  (track_id)
#
# Foreign Keys
#
#  fk_rails_...  (track_id => tracks.id)
#
class Layout < ApplicationRecord
  belongs_to :track
  has_one_attached :image
end
