# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  band_id    :integer
#  name       :string(255)
#  ttype      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Album < ActiveRecord::Base
  TTYPES = ['Studio', 'Live']

  validates :band_id, :name, presence: true
  validates :name, uniqueness: true
  validates :ttype, inclusion: TTYPES, allow_nil: true

  belongs_to :band
  has_many :tracks, dependent: :destroy
end
