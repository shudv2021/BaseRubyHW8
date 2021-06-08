module Counter
  def self.included(base)
    base.include(InstanceMethods)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def increase_counter
      counter
      #обращаемся к методу класса counter который возвращает значение @counter(при первом проходе 0)
      @counter += 1
      #instance переменная @counter при вызове модуля через extend поднимаеться на уровень и становиться
      # переменной класса, при вызове через include останется на уровне объект
    end

    def counter
      @counter||=0
      #||=0 вариант обьвления переменной
    end

  end

  module InstanceMethods
    def increase_counter
      self.class.increase_counter
      #метод обращается к одноименному методу среди методов класса, зачем непонятно. Чтобы код
      # внутри initialize сокрастить на 2а слова????????????
    end

  end
end
