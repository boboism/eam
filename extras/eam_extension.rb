class Module
  def eam_extension(method)
    if method_defined?(method)
      $stderr.puts "WARNING: Possible conflict with EAM extension:#{self}##{method} already exists"
    else
      yield
    end
  end
end
