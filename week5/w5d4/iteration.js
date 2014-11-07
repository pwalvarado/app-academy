var bubbleSort = function(array){
  var sorted = false;
  while (!sorted) {
    sorted = true;
    for (var i = 0; i < array.length - 1; i++){
      if (array[i] > array[i+1]){
        var tmp = array[i];
        array[i] = array[i+1];
        array[i+1] = tmp;
        sorted = false;
      }
    }
  }
  return array;
};

// console.log(bubbleSort([1,7,4,5,2,1]));

var substrings = function(string){
  var substringsArray = [];
  for (var start_index = 0; start_index < string.length; start_index++){
    for (var end_index = start_index; end_index < string.length; end_index++){
      substringsArray.push(string.slice(start_index, end_index+1));
    }
  }
  return substringsArray;
}

// console.log(substrings('reza'));

String.prototype.substrings = function(){
  var substringsArray = [];
  for (var start_index = 0; start_index < this.length; start_index++){
    for (var end_index = start_index; end_index < this.length; end_index++){
      substringsArray.push(this.slice(start_index, end_index+1));
    }
  }
  return substringsArray;
}


// console.log("random string".substrings());

Array.prototype.bubbleSort = function(){
  var sorted = false;
  while (!sorted) {
    sorted = true;
    for (var i = 0; i < this.length - 1; i++){
      if (this[i] > this[i+1]){
        var tmp = this[i];
        this[i] = this[i+1];
        this[i+1] = tmp;
        sorted = false;
      }
    }
  }
  return this;
};

console.log([2,3,6,0,-11,293,2].bubbleSort());
