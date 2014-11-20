Pokedex.Router = Backbone.Router.extend({
  routes: {
    '': "pokemonIndex",
    'pokemon/:id': 'pokemonDetail'
  },

  pokemonDetail: function (id, callback) {
    if (!this._pokemonIndex) {
      var that = this;
      this.pokemonIndex(
        function() {
          that.pokemonDetail(id, callback);
        } 
      );
      
    }
    var pokemon = this._pokemonIndex.collection.get(id);
    var pokemonDetail = new Pokedex.Views.PokemonDetail({
      model: pokemon
    });
    pokemonDetail.refreshPokemon({success: callback});
  },

  pokemonIndex: function (callback) {
    this._pokemonIndex  = this._pokemonIndex || new Pokedex.Views.PokemonIndex();
    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);
    this._pokemonIndex.refreshPokemon({success: callback});
  },

  toyDetail: function (pokemonId, toyId) {
  }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});

