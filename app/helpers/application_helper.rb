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
  
  def param_display(parameter)
    display = case parameter.type
      when 'String' : parameter.value
      when 'Date' : Date.parse(parameter.value).to_formatted_s(:main_date)
      else 'NOT DONE YET'
    end
  end
  
end
