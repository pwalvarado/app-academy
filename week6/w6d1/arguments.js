function sum () {
  var total = 0;
  for (var i = 0; i < arguments.length; i++) {
    total += arguments[i];
  }
  return total;
}

Function.prototype.myBind = function(obj){
  var fn = this;
  var args = Array.prototype.slice.call(arguments);
  
  return function () {
    var args2 = Array.prototype.slice.call(arguments);
    fn.apply(obj, args.slice(1).concat(args2));
  }
}

// var cat = {
//   name: "hi",
//   hi: function(x, y){
//     console.log(this.name + x + y)
//   }
// }
//
// var dog = {
//   name: "bye"
// }
//
// console.log(cat.hi.myBind(dog, "dog")("auster"))
//

function curriedSum (numsToSum) {
  var numbers = [];
  var _curriedSum = function (numToAdd) {
    numbers.push(numToAdd);
    if (numbers.length < numsToSum) {
      return _curriedSum;
    } else {
      return numbers.reduce( function(x, y) {return x + y;} );
    }
  }
  return _curriedSum;
}

Function.prototype.curry = function(numArgs) {
  var args = [];
  var that = this;
  var _curried = function (argToAdd) {
    args.push(argToAdd);
    if (args.length < numArgs) {
      return _curried;
    } else {
      return that.apply(null, args);
    }
  }
  return _curried;
}

var test = function(){
  var sum = 0;
  for (var i = 0; i < arguments.length; i++){
    sum += arguments[i];
  }
  return sum;
};