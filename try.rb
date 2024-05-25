nested_hash = {
  "a" => {
    "b" => {
      "c" => 1,
      "d" => 2
    },
    "e" => 3
  },
  "f" => 4
}

def process_for_hash(hash, temp = Hash.new, keys = String.new)
  hash.each do |key, value|
    n_keys = keys.empty? ? key : "#{keys}.#{key}"
    if value.is_a?(Hash)
      process_for_hash(value, temp, n_keys)
    else
      temp[n_keys] = value
    end
  end
  temp
end


puts process_for_hash(nested_hash)
