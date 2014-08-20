module ApplicationHelper

  def translate_field_name(form, field)
    t(field, scope: [ :activerecord, :attributes, form.object.class.to_s.underscore ])
  end

  def format_error_message(model, field, form)
    messages = model.errors[field]
    messages = [ messages ].flatten
    text = raw('')
    messages.each do |message|
      text << content_tag(:p,
        translate_field_name(form, field) + ' ' + message,
        style: "color: red; font-size: 14px;")
    end
    text
  end
end
