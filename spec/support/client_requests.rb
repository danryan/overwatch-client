def stub_get_plugin_manifest
  stub_request(:get, "http://api.monitaurapp.com/nodes/asdf1234/plugins").
    to_return(
      :status => 200,
      :body => %Q{
        [
          {
            "name": "plugin1",
            "checksum": "qwer5678"
          },
          {
            "name": "plugin2",
            "checksum": "hjkl4321"
          }
        ]
      }
    )
end

def plugin_manifest_response
  [
    {
      "name" => "plugin1",
      "checksum" => "qwer5678"
    },
    {
      "name" => "plugin2",
      "checksum" => "hjkl4321"
    }
  ]
end