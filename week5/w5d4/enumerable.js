var double = function(array) {
  var doubled = [];
  array.forEach(function(num){
    doubled.push(num*2);
  });
  return doubled;
};

// console.log(double([1,2,3,4]));

Array.prototype.myEach = function(callback) {
  for (var i = 0; i < this.length; i++){
    callback(this[i]);
  }
};

// var print = function(num){
//   console.log(num);
// };

// [1,2,3].myEach(print);

Array.prototype.myMap = function(mappingFunction) {
  var outputArray = [];
  this.myEach(function(element){
    outputArray.push(mappingFunction(element));
  });
  return outputArray;
};

var twoTimes = function(num){
  return num * 2;
};

// console.log([1,2,3,4].myMap(twoTimes));

Array.prototype.myInject = function(accumFunc) {
  var accum = this[0];
  this.slice(1,this.length).myEach(function(element){
    accum = accumFunc(accum, element);
  });
  return accum;
};

var sums = function(sum, num){
  return (sum + num);
};

console.log([1,2,3,4].myInject(sums));