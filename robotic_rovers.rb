require 'pry'

module RoboticRovers
  def handle_rovers
    input_file = File.read('./input.txt').split("\n")
    field = input_file.shift
    final_coordinates = []

    loop do
      break if input_file.empty?
      initial_coordinates = input_file.shift
      commands = input_file.shift
      final_coordinates.push(move_rover(initial_coordinates, commands))
    end
  end

  def move_rover(initial_coordinates, commands)
    return initial_coordinates if commands.length == 0
    next_command = commands.slice!(0)
    x = initial_coordinates.split(' ')[0].to_i
    y = initial_coordinates.split(' ')[1].to_i
    direction = initial_coordinates.split(' ')[2]
    case next_command
    when 'M'
      case direction
      when 'N'
        y = y + 1
      when 'S'
        y = y - 1
      when 'E'
        x = x + 1
      when 'W'
        x = x - 1
      else
        puts 'incorrect coordinates'
      end
    when 'R'
      case direction
      when 'N'
        direction = 'E'
      when 'S'
        direction = 'W'
      when 'E'
        direction = 'S'
      when 'W'
        direction = 'N'
      else
        puts 'incorrect coordinates'
      end
    when 'L'
      case direction
      when 'N'
        direction = 'W'
      when 'S'
        direction = 'E'
      when 'E'
        direction = 'N'
      when 'W'
        direction = 'S'
      else
        puts 'incorrect coordinates'
      end
    else
      puts 'incorrect command'
    end
    next_coordinates = "#{x} #{y} #{direction}"
    move_rover(next_coordinates, commands)
  end
end
