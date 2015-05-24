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
      super(rewrite_keys(attrs))
    end

    def decrement(*params)
      super(*rewrite_first_param_attr_name(params))
    end

    def decrement!(*params)
      super(*rewrite_first_param_attr_name(params))
    end

    def increment(*params)
      super(*rewrite_first_param_attr_name(params))
    end

    def increment!(*params)
      super(*rewrite_first_param_attr_name(params))
    end

    def toggle(*params)
      super(*rewrite_first_param_attr_name(params))
    end

    def toggle!(*params)
      super(*rewrite_first_param_attr_name(params))
    end

    def touch(*attrs)
      rewritten_attrs = attrs.map { |attr| rewrite_attr_name(attr) }
      super(*rewritten_attrs)
    end
    
    def update(*params)
      super(*rewrite_first_param_keys(params))
    end

    def update!(*params)
      super(*rewrite_first_param_keys(params))
    end

    def update_attr(*params)
      super(*rewrite_first_param_attr_name(params))
    end

    def update_columns(*params)
      super(*rewrite_first_param_keys(params))
    end

    private

    def rewrite_attr_name(attr)
      self.class.rewrite_attr_name(attr)
    end

    def rewrite_keys(attrs)
      self.class.rewrite_keys(attrs)
    end

    def rewrite_first_param_attr_name(params)
      params[0] = rewrite_attr_name(params[0])
      params
    end

    def rewrite_first_param_keys(params)
      params[0] = rewrite_keys(params[0])
      params
    end
  end
end
