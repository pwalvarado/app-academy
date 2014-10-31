# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  album_id   :integer
#  name       :string(255)
#  ttype      :string(255)
#  lyrics     :text
#  created_at :datetime
#  updated_at :datetime
#

class Track < ActiveRecord::Base
  TTYPES = ['Regular', 'Bonus']
  validates :album_id, :name, presence: true
  validates :name, uniqueness: { scope: :album_id }
  validates :ttype, inclusion: TTYPES, allow_nil: true
  belongs_to :album
  has_many :notes
end
