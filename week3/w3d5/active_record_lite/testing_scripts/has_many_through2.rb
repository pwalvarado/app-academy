require_relative '../lib/05_associatable3'

class Cat < SQLObject
  belongs_to :human, foreign_key: :owner_id
  has_many(
    :houses,
    through: :human,
    source: :houses
  )

  finalize!
end

class Human < SQLObject
  self.table_name = 'humans'

  has_many :cats, foreign_key: :owner_id
  has_many(
    :boats,
    class_name: 'Boat',
    foreign_key: :boat_owner_id,
    primary_key: :id
  )
  has_many_through(:marinas, :boats, :marina)

  finalize!
end

class Boat < SQLObject
  belongs_to(
    :boat_owner,
    class_name: 'Human',
    foreign_key: :boat_owner_id,
    primary_key: :id
  )
  belongs_to(
    :marina,
    class_name: 'Marina',
    foreign_key: :marina_id,
    primary_key: :id
  )

  finalize!
end


class Marina < SQLObject
  has_many(
    :boats,
    class_name: 'Boat',
    foreign_key: :marina_id,
    primary_key: :id
  )

  finalize!
end
