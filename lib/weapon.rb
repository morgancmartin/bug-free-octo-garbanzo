class Weapon
  attr_reader :damage, :name, :bot
  def initialize(name, damage = 10)
    raise ArgumentError unless name.is_a?(String)
    raise ArgumentError unless damage.is_a?(Fixnum)
    @name = name
    @picked_up = false
    @damage = damage 
  end

  def picked_up?
    @picked_up
  end

  def bot=(bot)
    raise ArgumentError unless bot.is_a?(BattleBot) || bot.nil?
    @bot = bot
  end

  def pick_up
    raise ArgumentError if @picked_up
    @picked_up = true
  end
end
