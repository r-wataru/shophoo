class ZenkakuValidator < ActiveModel::EachValidator
  KATAKANA_PATTERN = /\A[　\u{30a0}-\u{30fa}\u{30fc}-\u{30fe}\u{309b}\u{309c}]+\z/

  def validate_each(object, attribute, value)
    if options[:katakana]
      errors = []
      value.scan(/./) do |i|
        if i !~ KATAKANA_PATTERN
          unless i =~ /\A[A-Za-z0-9-]+\z/
            errors << i
          end
        end
      end
      if errors.count > 0
        object.errors.add(attribute, :zenkaku_katakana, options)
      end
    else
      begin
        errors = []
        value.scan(/./) do |i|
          if /[ -~｡-ﾟ]/ =~ i
            unless i =~ /\A[A-Za-z0-9-]+\z/
              errors << i
            end
          end
        end
        if errors.count > 0
          object.errors.add(attribute, :zenkaku, options)
        end
      rescue
        object.errors.add(attribute, :zenkaku, options)
      end
    end
  end
end
