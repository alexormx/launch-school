class Clock

  attr_reader :hours, :minutes

  ONE_DAY = 24 * 60

  def initialize(hours, minutes)
    @minutes = minutes
    @hours = hours
  end

  def self.at(hours, minutes=0)
    Clock.new(hours, minutes)
  end

  def +(add_minutes)
    minutes_since_midnight = compute_minutes_since_midnight + add_minutes
    while minutes_since_midnight >= ONE_DAY
      minutes_since_midnight -= ONE_DAY
    end
    compute_time_from(minutes_since_midnight)
  end

  def ==(other_time)
    hours == other_time.hours && minutes == other_time.minutes
  end

  def -(sub_minutes)
    minutes_since_midnight = compute_minutes_since_midnight - sub_minutes
    while minutes_since_midnight < 0
      minutes_since_midnight += ONE_DAY
    end

    compute_time_from(minutes_since_midnight)
  end

  def to_s
    format('%02d:%02d', hours, minutes);
  end

  private

  def compute_minutes_since_midnight
    total_minutes = 60 * hours + minutes
    total_minutes % ONE_DAY
  end

  def compute_time_from(minutes_since_midnight)
    hours, minutes = minutes_since_midnight.divmod(60)
    hours %= 24
    Clock.new(hours, minutes)
  end
  
end
