class RpsGame

  WEAPONS = ['Rock', 'Paper', 'Scissors']

  RULES = { ['Rock', 'Scissors']  => 'blunts',
            ['Scissors', 'Paper'] => 'cuts',
            ['Paper', 'Rock']     => 'wraps' }

  @weapons = WEAPONS
  @rules = RULES
  @setup = { player: 'Player', player_weapon: 'Rock', computer_weapon: 'Rock' }
  @results = { winner: nil, report: 'Rock meets Rock' }

  class << self
    attr_reader :weapons, :setup, :results
    private
    attr_reader :rules
    attr_writer :setup
  end

  def self.choose_player(name)
    self.setup[:player] = name
  end

  def self.choose_player_weapon(choice)
    self.setup[:player_weapon] = choice
  end

  def self.choose_computer_weapon
    self.setup[:computer_weapon] = weapons.sample
  end

  def self.play
    weapon1 = setup[:player_weapon]
    weapon2 = setup[:computer_weapon]
    message1 = rules[[weapon1, weapon2]]
    message2 = rules[[weapon2, weapon1]]
    write_report(weapon1, weapon2, message1, message2)
  end

  # private class methods

  def self.write_report(weapon1, weapon2, message1, message2)
    if message1
      report setup[:player], "#{weapon1} #{message1} #{weapon2}"
    elsif message2
      report 'Computer', "#{weapon2} #{message2} #{weapon1}"
    else
      report nil, "#{weapon1} meets #{weapon2}"
    end
  end

  def self.report(name, message)
    @results[:winner] = name
    @results[:report] = message
    results
  end

  private_class_method :write_report, :report

end
