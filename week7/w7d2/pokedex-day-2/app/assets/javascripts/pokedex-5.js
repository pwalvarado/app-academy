Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click li": "selectPokemonFromList"
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();
  },

  addPokemonToList: function (pokemon) {
    var listItem = JST['pokemonListItem']({
      pokemon: pokemon
    });
    this.$el.append(listItem);
  },

  refreshPokemon: function (options) {
    this.collection.fetch({
      success: function () {
        this.render();
         if (options && options.success) {
           options.success();
         }
      }.bind(this)
    });
  },

  render: function () {
    this.$el.empty();
    this.collection.each(function (pokemon) {
      this.addPokemonToList(pokemon);
    }.bind(this));
  },

  selectPokemonFromList: function (event) {
    var pokemonId = $(event.target).data('id');
    var pokemon = this.collection.get(pokemonId);
    Backbone.history.navigate('/' + pokemon.urlRoot + '/' + pokemonId, {trigger: true});
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    'click .toys li': 'selectToyFromList'
  },

  refreshPokemon: function (options) {
    this.model.fetch({
      success: function () {
        this.render();
        $('#pokedex .pokemon-detail').html(this.$el);
      }.bind(this)
    });
    
  },

  render: function () {
    var content = JST['pokemonDetail']({pokemon: this.model});
    this.$el.html(content);
    var toysUl = $("<ul class='toys'></ul>")
    this.model.toys().each(function (toy) {
      toysUl.append(JST['toyListItem']({toy: toy}));
    });
    this.$el.append(toysUl);
    return this;
  },

  selectToyFromList: function (event) {
    var toyId = $(event.target).data('id');
    var toy = this.model.toys().get(toyId);
    var toyDetail = new Pokedex.Views.ToyDetail({
      model: toy
    });
    $('#pokedex .toy-detail').html(toyDetail.$el);
    toyDetail.render();
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    var content = JST['toyDetail']({toy: this.model, pokes: []});
    this.$el.html(content);
    return this;
  }
});


// $(function () {
//   var pokemonIndex = new Pokedex.Views.PokemonIndex();
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
//   pokemonIndex.refreshPokemon();
// });

