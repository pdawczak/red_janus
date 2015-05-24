module Utils
  module LegacyActiveRecord

    def self.included(obj)
      obj.extend(KlassMethods)
    end

    module KlassMethods
      attr_reader :rules

      def rewrite(rule)
        rule = rule.each_with_object({}) do |(key, val), updated|
          updated[key.to_s] = val
        end

        (@rules ||= {}).merge!(rule)
      end

      def rewrite_keys(attrs)
        attrs.dup.each_with_object({}) do |(key, val), rewritten_attrs|
          rewritten_attrs[rewrite_attr_name(key)] = val
        end
      end

      def rewrite_attr_name(attr)
        defaults = -> { [nil, attr] }

        new_attr = rules.find(defaults) do |(from, to)| 
          from == attr.to_s.underscore
        end.last

        return new_attr.to_sym if attr.kind_of? Symbol
        new_attr
      end

    end

    def initialize(attrs = {})
      super(self.class.rewrite_keys(attrs))
    end

    def decrement(attr, by = 1)
      super(self.class.rewrite_attr_name(attr), by)
    end

    def decrement!(attr, by = 1)
      super(self.class.rewrite_attr_name(attr), by)
    end

    def increment(attr, by = 1)
      super(self.class.rewrite_attr_name(attr), by)
    end

    def increment!(attr, by = 1)
      super(self.class.rewrite_attr_name(attr), by)
    end

    def toggle(attr)
      super(self.class.rewrite_attr_name(attr))
    end

    def toggle!(attr)
      super(self.class.rewrite_attr_name(attr))
    end

    def touch(*attrs)
      rewritten_attrs = attrs.map { |attr| self.class.rewrite_attr_name(attr) }
      super(*rewritten_attrs)
    end
    
    def update(attrs)
      super(self.class.rewrite_keys(attrs))
    end

    def update!(attrs)
      super(self.class.rewrite_keys(attrs))
    end

    def update_attr(attr, val)
      super(self.class.rewrite_attr_name(attr), val)
    end

    def update_columns(attrs)
      super(self.class.rewrite_keys(attrs))
    end
  end
end
