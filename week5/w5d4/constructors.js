var Cat = function(name, owner){
  this.name = name;
  this.owner = owner;
};

Cat.prototype.cuteStatement = function(){
  return 'Everyone loves ' + this.name;
};


Cat.prototype.meow = function(){
  console.log('meoooowww!');
};

var markov = new Cat('Markov', 'Ned');
var curie = new Cat('Curie', 'Ned');
var breakfast = new Cat('Breakfast', 'Ned');

// console.log(markov.cuteStatement());
// console.log(curie.cuteStatement());
// console.log(breakfast.cuteStatement());

// markov.meow();
// curie.meow();
// breakfast.meow();

markov.meow = function () {
  console.log('MEEOWOWOWOWOWOWOWOWO!');
};

markov.meow();
curie.meow();
breakfast.meow();
