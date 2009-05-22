Base = {
  init: function(functionToRunOnLoad) {
    document.observe("dom:loaded", functionToRunOnLoad);
  }
}
