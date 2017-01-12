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
      final_coordinates.push(move_rover(initial_coordinates, commands, field))
    end

    output_text = final_coordinates.join("\n")
    open('./output.txt', 'w') { |f| f << output_text }
  end

  def move_rover(initial_coordinates, commands, field)
    return initial_coordinates if commands.length == 0
    next_command = commands.slice!(0)
    x = initial_coordinates.split(' ')[0].to_i
    y = initial_coordinates.split(' ')[1].to_i
    direction = initial_coordinates.split(' ')[2]
    case next_command
    when 'M'
      case direction
      when 'N'
        y += 1
      when 'S'
        y -= 1
      when 'E'
        x += 1
      when 'W'
        x -= 1
      else
        raise 'Incorrect coordinates'
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
        raise 'Incorrect coordinates'
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
        raise 'Incorrect coordinates'
      end
    else
      raise 'Incorrect command'
    end
    check_coordinates(x, y, field)
    next_coordinates = "#{x} #{y} #{direction}"
    move_rover(next_coordinates, commands, field)
  end

  def check_coordinates(x, y, field)
    max_x = field.split(' ').map(&:to_i)[0]
    max_y = field.split(' ').map(&:to_i)[1]
    raise 'Dron went out of boundaries of field' if x > max_x || y > max_y || x < 0 || y < 0
  end
end
