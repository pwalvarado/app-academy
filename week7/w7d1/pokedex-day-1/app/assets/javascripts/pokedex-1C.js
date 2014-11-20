Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var pokemon = new Pokedex.Models.Pokemon(attrs);
  pokemon.save({}, {
    success: function () {
      this.pokes.add(pokemon);
      this.addPokemonToList(pokemon);
      callback(pokemon);
    }.bind(this)
  });
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();
  var newPokemon = $(event.target).serializeJSON();
  this.createPokemon(newPokemon, this.renderPokemonDetail.bind(this));
};
