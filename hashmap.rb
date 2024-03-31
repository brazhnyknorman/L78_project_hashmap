# Hashmap class
class HashMap
  attr_accessor :buckets, :list, :capacity, :load_factor, :new_list

  def initialize
    @buckets = 16
    @list = []
    @buckets.times { |i| @list[i] = [nil, nil, nil] }

    @capacity = 0
    @load_factor = (@buckets / 2).round
    @new_list = []
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code
  end

  def set(key, value)
    @capacity += 1 unless has(key) == false

    index = get_index(key)

    @list[index][0] = hash(key) # Stores Hash
    @list[index][1] = value     # Stores value
    @list[index][2] = key       # Stores key

    rehash if grow?
  end

  def get_index(key)
    index = hash(key) % @buckets
    raise IndexError if index.negative? || index >= @buckets - 1

    index
  end

  def get_index_from_hash(hash)
    index = hash % @buckets
    raise IndexError if index.negative? || index >= @buckets - 1

    index
  end

  def get(key)
    index = get_index(key)
    @list[index][1]
  end

  def has(key)
    index = get_index(key)
    return true if @list[index][0] == hash(key)

    false
  end

  def remove(key)
    return nil if has(key) == false

    @capacity -= 1

    index = get_index(key)
    temp = @list[index][1]
    @list[index] = [nil, nil, nil]
    temp
  end

  def length
    @capacity
  end

  def clear
    initialize
  end

  def keys
    new_arr = []
    @list.each { |hashpair| new_arr << hashpair[2] unless hashpair[2].nil? }
    new_arr
  end

  def values
    new_arr = []
    @list.each { |hashpair| new_arr << hashpair[1] unless hashpair[1].nil? }
    new_arr
  end

  def entries
    new_arr = []
    @list.each { |hashpair| new_arr << [hashpair[2], hashpair[1]] unless hashpair[1].nil? || hashpair[2].nil?}
    new_arr
  end

  def grow?
    return true if @capacity >= @load_factor

    false
  end

  def rehash
    @buckets *= 2
    @load_factor = (@buckets / 2).round
    @buckets.times { |i| @new_list[i] = [nil, nil, nil] }
    @list.each do |hashpair|
      next unless hashpair.include?(nil) == false

      index = get_index_from_hash(hashpair[0])

      @new_list[index][0] = hashpair[0] # Hash
      @new_list[index][1] = hashpair[1] # Value
      @new_list[index][2] = hashpair[2] # Key
    end
    @list = @new_list
    @new_list = []
  end
end

ages = HashMap.new
ages.set('Carlos', 'I am the old value')
ges.set('Carlos', 'I am the new value')
