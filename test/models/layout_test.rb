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
require "test_helper"

class LayoutTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
