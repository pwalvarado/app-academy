Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var pokeString = pokemon.get("name") + ' (' + pokemon.get("poke_type") + ')';
  var $pokeLi = $('<li>').html(pokeString)
  $pokeLi.addClass('poke-list-item');
  $pokeLi.attr('data-id', pokemon.id);
  this.$pokeList.append($pokeLi);
};

Pokedex.RootView.prototype.refreshPokemon = function (callback) {
  this.pokes.fetch({
    success: function (collection, resp, options) {
      collection.each(function(pokemon){
        this.addPokemonToList(pokemon);
      }.bind(this));
    }.bind(this),
    error: function () {
      console.log("Errorrrr");
    }
  });
};
