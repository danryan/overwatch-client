module Overwatch
  module CLI
    module Command
      class Create < Resource

        option ['-n', '--name'], "NAME", "name of resource"

        def execute 
          puts "CREATE"
        end
      end
    end
  end
end
