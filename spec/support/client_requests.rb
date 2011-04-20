def stub_get_plugin_manifest
  stub_request(:get, "#{server_url}/nodes/#{client_key}/plugins").
    to_return(
      :status => 200,
      :body => %Q{
        [
          {
            "name": "foo_plugin",
            "checksum": "qwer5678"
          },
          {
            "name": "bar_plugin",
            "checksum": "hjkl4321"
          }
        ]
      }
    )
end

def plugin_manifest_response
  [
    {
      "name" => "foo_plugin",
      "checksum" => "qwer5678"
    },
    {
      "name" => "bar_plugin",
      "checksum" => "hjkl4321"
    }
  ]
end

def stub_sync_plugins
  stub_request(:get, "#{server_url}/plugins/foo_plugin").
    to_return(:body => stub_foo_plugin)
  
  stub_request(:get, "#{server_url}/plugins/bar_plugin").
    to_return(:body => stub_bar_plugin)
end

def stub_foo_plugin
  %|
  class FooPlugin < Monitaur::Plugin
    name "foo_plugin"
    desc "A test plugin to determine whether plugin sync works"

    def run
      { :foo => 'foo' }
    end
  end
  |
end

def stub_bar_plugin
  %|
  class BarPlugin < Monitaur::Plugin
    name "bar_plugin"
    desc "A test plugin to determine whether plugin sync works"

    def run
      { :bar => 'bar' }
    end
  end
  |
end