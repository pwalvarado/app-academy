var uniq = function (array) {
  var uniqArray = [];
  array.forEach(function(num){
    if (uniqArray.indexOf(num) == -1){
      uniqArray.push(num);
    }
  });
  return uniqArray;
};

// var array = [1, 2, 1, 3, 3];
//
// console.log(uniq(array));
//

var twoSum = function (array) {
  var resultArray = [];
  for (var i = 0; i < array.length; i++) {
    for (var j = i + 1; j < array.length; j++) {
      if(array[i] + array[j] === 0){
        resultArray.push([i, j]);
      }
    }
  }
  return resultArray;
};

// var array = [-1, 0, 2, -2, 1];
// console.log(twoSum(array));

var transpose = function (matrix) {
  var transposed = new Array(matrix[0].length);
  for(var i = 0; i < transposed.length; i++) {
    transposed[i] = new Array(3)
  };
  for (var i = 0; i < matrix.length; i++) {
    for (var j = 0; j < matrix[i].length; j++) {
      transposed[j][i] = matrix[i][j];
    }
  }
  return transposed;
};

var rows = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ];
console.log(transpose(rows));