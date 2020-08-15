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
  has_many :strategies, dependent: :destroy

  def add_strategy(user)
    strategy_name = "#{name}-#{user.email}"
    strategy = strategies.find_by_name(strategy_name)
    strategy ||= strategies.create!(name: strategy_name, user_id: user.id)
    strategy
  end
end
