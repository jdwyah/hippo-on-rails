module ApplicationHelper
  CORE_JAVASCRIPTS = [
    'prototype',
    'common',
    '/__utm.js'
  ] unless const_defined? :CORE_JAVASCRIPTS
  JAVASCRIPT_SHORTCUTS = {
  } unless const_defined? :JAVASCRIPT_SHORTCUTS

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
  
  def javascripts(*scripts, &block)
    @javascripts ||= [] # Tracks javascripts added so far

    # Handle multiple script args or single Array of script names
    scripts = (scripts.any? and scripts[0].is_a? Array) ? scripts[0] : scripts
    # Make sure we include core scripts, resolve shortcuts/dependencies and eliminate dupes
    scripts = (CORE_JAVASCRIPTS + scripts) if @javascripts.empty? # Add core scripts if first time called

    add_javascripts_to_page(scripts, &block)
  end

  #change javascript order to prepend before CORE_JAVASCRIPTS
  def prepend_javascripts(*scripts, &block)
    # Handle multiple script args or single Array of script names
    scripts = (scripts.any? and scripts[0].is_a? Array) ? scripts[0] : scripts
    add_javascripts_to_page(scripts + CORE_JAVASCRIPTS, &block)
  end

  def default_javascripts
    build_javascript_tags(CORE_JAVASCRIPTS)
  end

  private

  def add_javascripts_to_page(scripts, &block)
    @javascripts ||= [] # Tracks javascripts added so far

    scripts = flatten_javascripts(scripts) # Resolve any dependency shortcuts
    scripts.reject! { |s| @javascripts.include?(s) } # Skip previously added scripts

    # Build string of scripts tags and inline scripts to render
    output = build_javascript_tags(scripts) # Generate script include tags
    output << (capture(&block) + "\n") if block_given? # Generate inline scripts

    # Make javascript available to layouts
    content_for(:javascripts) { output }

    # Log scripts we've added so they're not included again later
    @javascripts += scripts
  end

  def flatten_javascripts(javascripts)
    javascripts.uniq.map { |js| flatten_javascript(js) }.flatten
  end

  def flatten_javascript(script_name)
    js_string = script_name.to_s
    # Check if script name is a shortcut that maps to an array of libs
    JAVASCRIPT_SHORTCUTS[js_string] || [js_string]
  end
  
  def build_javascript_tags(javascripts)
    output = javascripts.uniq.map do |script_name|
      javascript_include_tag(script_name.to_s)
    end.join("\n")

    return output + "\n"
  end
end
