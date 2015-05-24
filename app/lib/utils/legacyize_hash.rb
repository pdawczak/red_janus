module Utils
  module LegacyizeHash
    refine Object do
      def underscore
        self
      end
    end

    refine Symbol do
      def underscore
        self.to_s.underscore.to_sym
      end
    end

    refine Hash do
      def legacyize
        self.dup.each_with_object({}) do |(key, val), new_hash|
          new_hash[key.underscore] = val
        end
      end
    end
  end
end
