# Demonstrate monkey-patching of the Class object to change base Ruby behavior
class Class
  def attr_accessor_with_history(attr_name)
    attr_name = attr_name.to_s # make sure it's a string
    attr_reader attr_name # create the attribute's getter

    # HINT See use of string literals https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Literals#The_%_Notation
    attr_reader attr_name + '_history' # create bar_history getter
    class_eval %(
    def #{attr_name}=(new_attr)
      if @#{attr_name}_history.nil?
        @#{attr_name}_history = (@#{attr_name}.nil?) ? [nil] : [@#{attr_name}]
      end
      @#{attr_name}_history << new_attr
      @#{attr_name} = new_attr
    end
    ), __FILE__, __LINE__ - 8
  end
end

