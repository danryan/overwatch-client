class FooPlugin  # < Monitaur::Plugin
  name = "foo_plugin"
  desc = "A test plugin to determine whether plugin sync works"
  
  def run
    { :foo => 'foo' }
  end
end