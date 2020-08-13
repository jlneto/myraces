# == Schema Information
#
# Table name: points
#
#  id          :bigint           not null, primary key
#  coordinates :string
#  decription  :string
#  dislikes    :integer
#  likes       :integer
#  name        :string
#  tags        :string
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  strategy_id :bigint           not null
#
# Indexes
#
#  index_points_on_strategy_id  (strategy_id)
#
# Foreign Keys
#
#  fk_rails_...  (strategy_id => strategies.id)
#
require 'test_helper'

class PointTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
