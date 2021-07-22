# frozen_string_literal: true

# Class that implements Round Robin Collect from an array of hashes
#
# Parameters:
#   hash: hash from where values will be collected
#   max_items: maximum quantity of items collected from the hash
#   prop: property of the hash item to be collected
class RoundRobinCollect
  def self.collect(hash, max_items, prop)
    # First, it is necessary to ensure proper parameters are given
    raise "Hash paramenter expected. Got #{hash.class}" if hash.class != Hash
    raise "Fixnum parameter expected. Got #{max_items.class}" if max_items.class != Integer
    raise "String parameter expected. Got #{prop.class}" if prop.class != String

    elem_count = hash.values.flatten.count

    # Here, I constraint the max_items param to the maximum quantity
    # of items in the hash
    count = elem_count > max_items ? max_items : elem_count

    collect_items(hash, count, prop)
  end

  def self.collect_items(hash, count, prop)
    arr = []
    # In the worst case scenario where all items are present in only
    # one catergory (logs, content, myad) it is necessary to loop N
    # times the entire hash. That's why I loop wih 'count.times' and
    # not a lower value.
    count.times do |i|
      hash.each_key do |key|
        val = hash[key][i]
        arr << val[prop] if val
      end
      # This is an heuristic. If the array elements are equal or
      # higher than the required elements, simply breaks the loop.
      break if arr.count >= count
    end
    arr[0, count]
  end

  private_class_method :collect_items
end
