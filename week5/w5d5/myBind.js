Function.prototype.myBind = function (context) {
  fn = this;
  return function () {
    fn.apply(context);
  };
} 

// var sayName = function() {
//   console.log('my name is ' + this.name);
// };

// markov = {
//   name: 'markov'
// };

// markovSayingHisName = sayName.bind(markov);

// markovSayingHisName();