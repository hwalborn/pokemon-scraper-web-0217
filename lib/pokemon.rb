class Pokemon
  attr_accessor :id, :name, :type, :db, :hp

  def initialize(poke_hash)
    @id = poke_hash[:id]
    @name = poke_hash[:name]
    @type = poke_hash[:type]
    @db = poke_hash[:db]
    @hp = poke_hash[:hp]
  end

  def alter_hp(new_hp, db)
    db.execute("UPDATE pokemon SET hp = ? WHERE name = ?;", new_hp, self.name)
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?);", name, type)
  end

  def self.find(id, db)
    poke_arr = db.execute("SELECT * FROM pokemon WHERE pokemon.id = ?;", id)
    Pokemon.new(make_poke_hash(poke_arr, db))
  end

  def self.make_poke_hash(arr, db)
    {
      id: arr[0][0],
      name: arr[0][1],
      type: arr[0][2],
      hp: arr[0][3],
      db: db
    }
  end
end
