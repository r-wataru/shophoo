class HankakuValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    if options[:type] == :number
      if object.respond_to?("#{attribute}_before_type_cast")
        value = object.send("#{attribute}_before_type_cast")
      end
      unless value.to_s =~ /\A[0-9]+\z/
        object.errors.add(attribute, :hankaku_number)
      end
    elsif options[:type] == :alpha
      unless value =~ /\A[A-Za-z]+\z/
        object.errors.add(attribute, :hankaku_alpha)
      end
    elsif options[:type] == :alnum
      unless value =~ /\A[A-Za-z0-9]+\z/
        object.errors.add(attribute, :hankaku_alnum)
      end
    else
      unless value =~ /\A[ -~]+\z/
        object.errors.add(attribute, :hankaku)
      end
    end
  end
end
