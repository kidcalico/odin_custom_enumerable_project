module Enumerable
  # Your code goes here
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    index = 0
    self.my_each do |elem|
      yield(elem, index)
      index += 1
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    arr = []
    self.my_each { |item| arr << item if yield(item) }

    return arr
  end

  def my_all?
    return to_enum(:my_all?) unless block_given?

    self.my_each { |item| return false unless yield(item) }

    return true
  end

  def my_any?
    return to_enum(:my_any?) unless block_given?

    self.my_each { |item| return true if yield(item) }

    return false
  end

  def my_none?
    return to_enum(:my_none?) unless block_given?

    self.my_each { |item| return false if yield(item) }

    return true
  end

  def my_count
    count = 0

    unless block_given?
      self.my_each { |item| count += 1 }
      return count
    end

    self.my_each { |item| count += 1 if yield(item) }

    return count
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    arr = []
    self.my_each { |item| arr << yield(item) }

    return arr
  end

  def my_inject(initial = 1)
    return to_enum(:my_inject) unless block_given?

    output = nil
    self.my_each_with_index do |value, index|
      output = yield(initial, value) if index == 0
      output = yield(output, value) if index != 0
    end

    return output
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    return to_enum(:my_each) unless block_given?
    
    for item in self
      yield(item)
    end
  end
end
