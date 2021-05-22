class BeerSong
  class << self
    def verse(num)
      generate_verse(num)
    end

    def lyrics
      result = []
      (0..99).reverse_each do |idx|
        result << generate_verse(idx)
      end 
      result.join("\n")
    end

    def verses(start, finish)
      result = []
      (finish..start).reverse_each do |idx|
        result << generate_verse(idx)
      end
      result.join("\n")
    end

    private
    
    def generate_verse(bottles)
      case bottles
      when 0
        "No more bottles of beer on the wall, no more bottles " +
        "of beer.\nGo to the store and buy some more, 99 bottles " +
        "of beer on the wall.\n"
      when 1
        "1 bottle of beer on the wall, 1 bottle of beer.\n" +
        "Take it down and pass it around, no more bottles of beer " +
        "on the wall.\n"
      when 2
        "2 bottles of beer on the wall, 2 bottles of beer.\n" +
        "Take one down and pass it around, 1 bottle of beer " +
        "on the wall.\n"
      else
        "#{bottles} bottles of beer on the wall, #{bottles}" +
        " bottles of beer.\nTake one down and pass it around, " +
        "#{bottles-1} bottles of beer on the wall.\n"
      end
    end
  end
end
