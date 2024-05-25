class CategoryTree
  def initialize
    @data = []
  end

  def add_category(category, parent)
    begin
      check_category_alreday_exitst(category)
      @data << build_hash_object(category, parent)
    rescue => e
      puts e.message
    end
  end

  def build_hash_object(category, parent)
    {
      name: category,
      parent: parent
    }
  end

  def check_category_alreday_exitst(category)
    is_present_ct = @data.detect{ |obj| obj[:name] == category }
    is_present_ct.nil? ? nil : raise("Category allreday present")
  end


  def get_children(category)
    @data.select { |it| category == it[:parent] }
  end

end

c = CategoryTree.new 
c.add_category('A', nil)
c.add_category('B', 'A')
c.add_category('C', 'A')
puts (c.get_children('A') || []).join(',')