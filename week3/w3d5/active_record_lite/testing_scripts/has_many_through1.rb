require_relative '../lib/05_associatable3'

class Cat < SQLObject
  belongs_to :human, foreign_key: :owner_id
  has_many_through(:boats, :human, :boats)

  finalize!
end

class Human < SQLObject
  self.table_name = 'humans'

  has_many(
    :boats,
    class_name: 'Boat',
    foreign_key: :boat_owner_id,
    primary_key: :id
  )
  has_many :cats, foreign_key: :owner_id

  finalize!
end

class Boat < SQLObject
  belongs_to(
    :boat_owner,
    class_name: 'Human',
    foreign_key: :boat_owner_id,
    primary_key: :id
  )

  finalize!
end
