module PhoneNumbers
  extend ActiveSupport::Concern

  module ClassMethods
    def phone_columns(*names)
      names.each do |name|
        attr_writer :"#{name}1", "#{name}2", "#{name}3"

        1.upto(3) do |num|
          define_method :"#{name}#{num}" do
            if instance_variable_defined?("@#{name}#{num}")
              return instance_variable_get("@#{name}#{num}")
            end

            str = send(name)
            if str.present? and m = /^([0-9]+)-([0-9]+)-([0-9]+)$/.match(str)
              val = m[num]
            end
            instance_variable_set("@#{name}#{num}", val)
          end
        end

        define_method :"set_#{name}" do
          vals = [send("#{name}1"), send("#{name}2"), send("#{name}3")]
          if vals.all? {|v| v.present? }
            send("#{name}=", vals.join("-"))
          else
            send("#{name}=", "")
          end
        end
        private :"set_#{name}"
        before_save :"set_#{name}"

        define_method :"check_#{name}" do
          vals = [send("#{name}1"), send("#{name}2"), send("#{name}3")]

          return if vals.all? {|v| v.nil? }

          if vals.any? {|v| v.present? && v !~ /\A[0-9]+\z/ }
            errors.add(:"#{name}", :not_an_phone_is_integer)
          end

          if vals.any? {|v| v.present? } && vals.any? {|v| v.blank? }
            errors.add(:"#{name}", :blank_any)
          end

          if vals.all? {|v| v.present? }
            if vals[0].size + vals[1].size + vals[2].size > 11
              errors.add(:"#{name}", :too_long_phone, count: 11)
            end
          end
        end
        private :"check_#{name}"
        validate :"check_#{name}"
      end
    end
  end
end
