# module DatabaseConnection
#   def connection
#     puts "Connected to the database"
#   end
# end


# class User
#   include DatabaseConnection
# end

# class Post
#   extend DatabaseConnection
# end

# # include
# user = User.new
# user.connection

# # extend
# Post.connection


arr = [21, 10, 12, 19, 20]


def process_for_second_larget_element(arr)
  max = 0
  second = 0
  arr.each do |el|
    if el > max
      second = max
      max = el
    elsif el > second && el < max
      second = el
    end
  end
  second
end

p process_for_second_larget_element(arr)