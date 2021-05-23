class Robot
  @@names = []

  def name
    return @name if @name
    @name = generate_name while @@names.include?(@name) || @name.nil?
    @@names << @name
    @name
  end

  def reset
    @@names.delete(@name)
    @name = nil
  end

  private

  def generate_name
    name = ""
    2.times {name << rand(65..90).chr}
    3.times {name << rand(0..9).to_s}
    name
  end


end