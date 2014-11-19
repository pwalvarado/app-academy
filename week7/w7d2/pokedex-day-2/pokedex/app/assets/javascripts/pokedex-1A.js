Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var li = JST['pokemonListItem']({pokemon: pokemon});
  this.$pokeList.append(li);
};

Pokedex.RootView.prototype.refreshPokemon = function (callback) {
  this.pokes.fetch({
    success: (function () {
      this.$pokeList.empty();
      this.pokes.each(this.addPokemonToList.bind(this));
      callback && callback();
    }).bind(this)
  });

  return this.pokes;
};
