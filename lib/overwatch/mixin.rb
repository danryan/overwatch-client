module Overwatch
  module Mixin
    def file_exists_and_is_readable?(filename)
      File.exist?(filename) && File.readable?(filename)
    end
  end
end