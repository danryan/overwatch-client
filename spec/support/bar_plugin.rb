class BarPlugin # < Monitaur::Plugin
  name = "bar_plugin"
  desc = "A test plugin to determine whether plugin sync works"
  
  def run
    { :bar => 'bar' }
  end
end