module Counter
  def self.included(base)
    base.include(InstanceMethods)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def increase_counter
      counter
      @counter += 1
    end

    def counter
      @counter ||= 0
    end
  end

  module InstanceMethods
    def increase_counter
      self.class.increase_counter
    end
  end
end
