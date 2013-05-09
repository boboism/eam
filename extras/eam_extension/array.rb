require './extras/eam_extension.rb'

class Array
  eam_extension("^") do
    def ^(other)
      (self | other) - (self & other)
    end
  end
end
