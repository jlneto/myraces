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
end
