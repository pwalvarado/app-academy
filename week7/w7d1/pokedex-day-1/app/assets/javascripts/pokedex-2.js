Pokedex.RootView.prototype.addToyToList = function (toy) {
  var $toyLi = $('<li>');
  var toyInfo = toy.get("name") + "(price: " + toy.get("price") + ", happiness: " + toy.get("happiness") + ")";
  $toyLi.html(toyInfo);
  this.$el.find('.toys').append($toyLi)
  
  return $toyLi
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) { 
  var $toyDetail = $('<div>').addClass("detail");
  
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
};
