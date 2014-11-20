Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var $pokeDetail = $("<div>").addClass("detail");
  var $pokeImg = $("<img>").attr("src", pokemon.get("image_url"));
  var $name = $('<p>').html('<strong>name: </strong>' + pokemon.get('name'));
  var $attack = $('<p>').html('<strong>attack: </strong>' + pokemon.get('attack'));
  var $defense = $('<p>').html('<strong>defense: </strong>' + pokemon.get('defense'));
  var $poke_type = $('<p>').html('<strong>poke type: </strong>' + pokemon.get('poke_type'));
  var $moves = $('<p>').html('<strong>moves: </strong>' + pokemon.get('moves').join(', '));
  var $toys =  $('<ul>').addClass("toys");
  pokemon.fetch({
    success: function () {
      pokemon.toys().each(function (toy) {
        this.addToyToList(toy);
      }.bind(this));
    }.bind(this)
  });
  
  $pokeDetail.append($pokeImg, $name, $attack, $defense, $poke_type, $moves, $toys);
  this.$pokeDetail.html($pokeDetail);
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var id = $(event.target).data("id");
  var pokemon = this.pokes.get(id);
  this.renderPokemonDetail(pokemon);
};
