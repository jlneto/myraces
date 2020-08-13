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

end
