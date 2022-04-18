class CinemaSql

  def initialize()
    @people = File.readlines("./people.txt", "\n")
    @titles = File.readlines("./titles.txt", "\n")
  end

  def write_script()
    File.write("../marvel.sql", generate_script() )
  end

  def generate_script()
    return header() + people().join("\n") + "\n\n" + titles().join("\n") + "\n\n"
  end

  def people()
    return @people.map do |person|
      "INSERT INTO people (name) VALUES ('#{person.chomp}');"
    end
  end

  def titles()
    return @titles.map do |movie|
      "INSERT INTO movies (title, year, show_time) VALUES ('#{get_title(movie)}', #{get_year(movie)}, '#{random_time()}');"
    end
  end

  def random_hour()
    return rand(12) + 12
  end

  def random_minute()
    minute = (rand(12) * 5).to_s
    minute = '0' + minute if minute.length == 1
    return minute
  end

  def random_time()
    return "#{random_hour}:#{random_minute}"
  end

  def get_title( movie )
    title = movie.chomp.split(' ')
    title.pop()
    return title.join(' ')
  end

  def get_year( movie )
    return movie.chomp.split(' ').at(-1).tr('()', '')
  end

  def rand_id( num )
    return rand(num) + 1
  end

  def header()
    return "DROP TABLE movies;\nDROP TABLE people;\n\nCREATE TABLE movies (\n\tid SERIAL PRIMARY KEY,\n\ttitle VARCHAR(255),\n\tyear INT,\n\tshow_time VARCHAR(255)\n);\n\nCREATE TABLE people (\n\tid SERIAL PRIMARY KEY,\n\tname VARCHAR(255)\n);"
  end

end

sql = CinemaSql.new

sql.write_script()
