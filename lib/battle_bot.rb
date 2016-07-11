class BattleBot
  attr_reader :name, :health, :enemies, :weapon
  def initialize(name)
    raise ArgumentError if name.nil?
    @name = name
    @health = 100
    @enemies = []
    @weapon = nil
    @dead = false
    @@count += 1
  end

  def self.count
    @@count
  end

  def weapon=(item)
    raise NoMethodError
  end

  def pick_up(weapon)
    raise ArgumentError unless weapon.is_a?(Weapon)
    return nil if has_weapon?
    weapon.bot = self if weapon.pick_up
    @weapon = weapon
  end

  def attack(other_bot)
    raise ArgumentError if other_bot == self || !other_bot.is_a?(BattleBot) ||
                           !has_weapon?
    other_bot.receive_attack_from(self)
  end

  def receive_attack_from(other_bot)
    raise ArgumentError if !other_bot.is_a?(BattleBot) || other_bot == self ||
                           !other_bot.has_weapon?
    @enemies << other_bot unless @enemies.include?(other_bot)
    take_damage(other_bot.weapon.damage)
    defend_against(other_bot)
  end

  def defend_against(enemy)
    if !dead? && has_weapon?
      attack(enemy)
    end
  end

  def heal
    return nil if @dead
    @health += 10
    @health = 100 if @health > 100
    @health
  end

  def drop_weapon
    @weapon.bot = nil
    @weapon = nil
  end

  def has_weapon?
    !@weapon.nil?
  end

  def take_damage(amount)
    if amount > @health
      @health = 0
      @dead = true
      @@count -= 1
    else
      @health -= amount
    end
  end

  def dead?
    @dead
  end

end
