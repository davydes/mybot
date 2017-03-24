module CoreExtensions
  module String
    module Transformations
      def camelize
        self.split('_').map(&:capitalize).join
      end
    end
  end
end

String.include CoreExtensions::String::Transformations
