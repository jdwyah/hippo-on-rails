module ApplicationHelper
   def body_attributes
    {:class => body_class, :id => body_id}
  end

  def body_class
    @controller.controller_name.dasherize
  end

  def body_id
    "#{@controller.controller_name.dasherize}-#{@controller.action_name.dasherize}"
  end
  
  def property_display(property)
    display = case property.property_type.type_name
      when 'String' : parameter.value
      when 'Date' : Date.parse(parameter.value).to_s(:main_date)
      else 'NOT DONE YET'
    end
  end
  
  def property_edit(builder)
    display = case builder.object.property_type.type_name
      when 'String' : builder.text_field :value
      when 'Date' : builder.date_select :value
      else 'NOT DONE YET'
    end
  end
  
  def add_property_type_link(name, form)
    link_to_function name do |page|
      property_type = partial 'topics/property_type_form', :builder => form, :property_type => PropertyType.new
      page << %{
        var new_property_type_id = "new_" + new Date().getTime();
        $('property_types').insert({ bottom: "#{ escape_javascript property_type }".replace(/new_\\d+/g, new_property_type_id) });
      }
    end
  end
  
end
