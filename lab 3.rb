
 class Context
     # Контекст хранит ссылку на один из объектов Стратегии. Контекст не знает
     # конкретного класса стратегии. Он должен работать со всеми стратегиями через
     # интерфейс Стратегии
 @return [Strategy]
     attr_writer :strategy

     # Обычно Контекст принимает стратегию через конструктор, а также предоставляет
     # сеттер для её изменения во время выполнения.

 @param [Strategy] strategy
     def initialize(strategy)
       @strategy = strategy
     end
  

 @param [Strategy] strategy
     def strategy=(strategy)
       @strategy = strategy
     end
  
     # Вместо того, чтобы самостоятельно реализовывать множественные версии
     # алгоритма, Контекст делегирует некоторую работу объекту Стратегии.
     def do_some_business_logic
  
  
       puts 'Context: Sorting data using the strategy (not sure how it\'ll do it)'
       result = @strategy.do_algorithm(%w[a b c d e])
       print result.join(',')
  

     end
   end

   # Интерфейс Стратегии объявляет операции, общие для всех поддерживаемых версий
   # некоторого алгоритма.

   # Контекст использует этот интерфейс для вызова алгоритма, определённого
   # Конкретными Стратегиями.
   
 @abstract
   class Strategy
     @abstract

 @param [Array] data
     def do_algorithm(_data)
       raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
     end
   end
  

  
   class ConcreteStrategyA < Strategy
 @param [Array] data

 @return [Array]
     def do_algorithm(data)
      data.sort
     end
   end
  
   class ConcreteStrategyB < Strategy
     # @param [Array] data

 @return [Array]
     def do_algorithm(data)
       data.sort.reverse
     end
   end
  
   # Клиентский код выбирает конкретную стратегию и передаёт её в контекст. Клиент
  # должен знать о различиях между стратегиями, чтобы сделать правильный выбор.
  
   context = Context.new(ConcreteStrategyA.new)
   puts 'Client: Strategy is set to normal sorting.'
   context.do_some_business_logic
   puts "\n\n"
  
   puts 'Client: Strategy is set to reverse sorting.'
   context.strategy = ConcreteStrategyB.new
   context.do_some_business_logic

 # Интферфейс издателя объявляет набор методов для управлениями подписчиками.

 @abstract
 class Subject
     # Присоединяет наблюдателя к издателю.

 @abstract

 @param [Observer] observer
     def attach(observer)
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
  
     # Отсоединяет наблюдателя от издателя.

 @abstract

 @param [Observer] observer
     def detach(observer)
       raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
  
     # Уведомляет всех наблюдателей о событии.

 @abstract
     def notify
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
     end
  end
  
   # Издатель владеет некоторым важным состоянием и оповещает наблюдателей о его
   # изменениях.
   class ConcreteSubject < Subject
    # Для удобства в этой переменной хранится состояние Издателя, необходимое всем
     # подписчикам.
    attr_accessor :state
  
 @!attribute observers
@return [Array<Observer>] attr_accessor :observers private :observers
  
     def initialize
      @observer = []
     end
  
     # Список подписчиков. В реальной жизни список подписчиков может храниться в
     # более подробном виде (классифицируется по типу события и т.д.)
  
 @param [Obserser] observer
    def attach(observer)
      puts 'Subject: Attached an observer.'
      @observers << observer
    end
  
 @param [Obserser] observer
    def detach(observer)
       @observers.delete(observer)
    end
  
    # Методы управления подпиской.
  
    # Запуск обновления в каждом подписчике.
    def notify
      puts 'Subject: Notifying observers...'
       @observers.each { |observer| observer.update(self) }     end
  
    # Обычно логика подписки – только часть того, что делает Издатель. Издатели
     # часто содержат некоторую важную бизнес-логику, которая запускает метод
     # уведомления всякий раз, когда должно произойти что-то важное (или после
     # этого).
     def some_business_logic
       puts "\nSubject: I'm doing something important."
       @state = rand(0..10)
  
       puts "Subject: My state has just changed to: #{@state}"
       notify
    end
   end
  
   # Интерфейс Наблюдателя объявляет метод уведомления, который издатели используют
   # для оповещения своих подписчиков.

 @abstract
   class Observer
     # Получить обновление от субъекта.

 @abstract

 @param [Subject] subject
     def update(_subject)
       raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
     end
   end
  
   # Конкретные Наблюдатели реагируют на обновления, выпущенные Издателем, к
   # которому они прикреплены.
  
   class ConcreteObserverA < Observer
 @param [Subject] subject
     def update(subject)
       puts 'ConcreteObserverA: Reacted to the event' if subject.state < 3
     end
   end
  
   class ConcreteObserverB < Observer
 @param [Subject] subject
     def update(subject)
       return unless subject.state.zero? || subject.state >= 2
  
       puts 'ConcreteObserverB: Reacted to the event'
     end
   end
  
   # Клиентский код.
  
   subject = ConcreteSubject.new
  
   observer_a = ConcreteObserverA.new
   subject.attach(observer_a)
  
   observer_b = ConcreteObserverB.new
   subject.attach(observer_b)
  
   subject.some_business_logic
   subject.some_business_logic
  
   subject.detach(observer_a)
  
   subject.some_business_logic
  













# Интерфейс Абстрактной Фабрики объявляет набор методов, которые возвращают
# различные абстрактные продукты. Эти продукты называются семейством и связаны
# темой или концепцией высокого уровня. Продукты одного семейства обычно могут
# взаимодействовать между собой. Семейство продуктов может иметь несколько
# вариаций, но продукты одной вариации несовместимы с продуктами другой.

 @abstract
class AbstractFactory
    # @abstract
    def create_product_a
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
  
    # @abstract
    def create_product_b
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
  end
  
  # Конкретная Фабрика производит семейство продуктов одной вариации. Фабрика
  # гарантирует совместимость полученных продуктов. Обратите внимание, что
  # сигнатуры методов Конкретной Фабрики возвращают абстрактный продукт, в то
  # время как внутри метода создается экземпляр конкретного продукта.
  class ConcreteFactory1 < AbstractFactory
    def create_product_a
      ConcreteProductA1.new
    end
  
    def create_product_b
      ConcreteProductB1.new
    end
  end
  
  # Каждая Конкретная Фабрика имеет соответствующую вариацию продукта.
  class ConcreteFactory2 < AbstractFactory
    def create_product_a
      ConcreteProductA2.new
    end
  
    def create_product_b
      ConcreteProductB2.new
    end
  end
  
  # Каждый отдельный продукт семейства продуктов должен иметь базовый интерфейс.
  # Все вариации продукта должны реализовывать этот интерфейс.
  #
  # @abstract
  class AbstractProductA
    # @abstract
    #
    # @return [String]
    def useful_function_a
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
  end
  
  # Конкретные продукты создаются соответствующими Конкретными Фабриками.
  class ConcreteProductA1 < AbstractProductA
    def useful_function_a
      'The result of the product A1.'
    end
  end
  
  class ConcreteProductA2 < AbstractProductA
    def useful_function_a
      'The result of the product A2.'
    end
  end
  
  # Базовый интерфейс другого продукта. Все продукты могут взаимодействовать друг
  # с другом, но правильное взаимодействие возможно только между продуктами одной
  # и той же конкретной вариации.
  #
  # @abstract
