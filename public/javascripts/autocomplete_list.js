AutocompleteList = Class.create({

  //expectations:
  // A UL named #{prefix}_holder
  // Input with name: #{prefix}_name
  // Div to populate with name: #{prefix}_name_auto_complete
  //
  // Autocomplete URL responds with
  //     <span class="parameters" style="display:none">
  //          <span class="#{prefix}_id">114</span>
  //          <span class="#{prefix}_name">Name</span>
  //     </span>
  //     <div class="#{prefix}-name"><strong>Na</strong>me</div>
  //
  // example AutocompleteList('treatment', 's[t][]', '/treatments/treatment_name_auto_complete?simple=true',
  // "[{"name": "Celebrex", "id": 1}, {"name": "Rilutek", "id": 2}]",
  // {indicator:'treatment-ac-loading-indicator', minChars:3, select:'treatment-name'}


  initialize: function(prefix, form_field_name, url, init_json, user_options) {
    this.prefix = prefix;
    this.form_field_name = form_field_name;
    options = $H({
      json_field_for_name: 'name',
      updateElement: this.autocomplete.bind(this),
      select: prefix+'-name',
      indicator: prefix+'-ac-loading-indicator',
      deleteClickable: ' &times;'
    });

    this.options = options.merge(user_options)

    new Ajax.Autocompleter(prefix+'_name',
      prefix+'_name_auto_complete',
      url, this.options.toObject());

    $(this.prefix+'_holder').observe('click', Event.delegate({
      'a.delete' : this.removeTreatment.bind(this)
    }));

    init_json.each(function(json){
      this.addChosen(json['id'],json[this.options.get('json_field_for_name')]);
    }.bind(this));
    this.setLevelZero();
  },
  autocomplete: function(li) {
    var id = li.down('.parameters .'+this.prefix+'_id').innerHTML
    var name = li.down('.parameters .'+this.prefix+'_name').innerHTML
    this.addChosen(id, name);
    $(this.prefix + '_name').clear();
    this.submitForm();
  },
  addChosen: function(_id, name){
    var id = (_id+'');
    var duplicates = $$("input[name='"+this.form_field_name+"'][value='"+id+"']");
    if(duplicates.size() > 0){
      return;
    }
    var tx_li = $li(this.chosenDisplay(name), $a({
      href: '#'
    }, this.options.get('deleteClickable')).addClassName('delete'));
    tx_li.select('a.delete').first().update(this.options.get('deleteClickable'));
    tx_li.appendChild($input({
      type: 'hidden',
      name: this.form_field_name,
      value: id
    }));

    $(this.prefix + '_holder').appendChild(tx_li);
    this.setLevelZero();
  },
  chosenDisplay: function(name){
    return $span(name).addClassName('name');
  },
  setLevelZero: function(){
    if(this.options.get('levelZeroText') && $$('#'+this.prefix + '_holder li').size() == 0){
      $(this.prefix + '_holder').appendChild($div({className: 'level-zero-text'},this.options.get('levelZeroText')));
    } else {
      $$('#'+this.prefix + '_holder .level-zero-text').invoke('remove');
    }
  },
  removeTreatment: function(e){
    e.element().up('li').remove();
    this.setLevelZero();
    this.submitForm();
    e.stop();
  },
  submitForm: function(){
    //no-op
  }

})

var SubmittingAutocompleteList = Class.create(AutocompleteList, {
  submitForm: function(){
    $$("input[name='"+this.prefix+"_name']").first().up('form').request();
  }
})
var AdvSearchAutocompleteList = Class.create(AutocompleteList, {
  submitForm: function(){
    AdvSearch.requestFormSubmit();
  }
})
var ForumBlockAutocompleteList = Class.create(AutocompleteList, {
  submitForm: function(){
    $$('.error').invoke('remove');
    $$("input[name='"+this.prefix+"_name']").first().up('form').request();
  },
  chosenDisplay: function(name){
    return $a({href: 'tags/'+name.trim()}, name).addClassName('name');
  }
})

