var range = function (start, end) {
  if (end <= start) {
    return [];
  } else {
    var next = range(start, end - 1);
    next.push(end - 1);
    return next;
  }
};

// console.log(range(2,5));

var expSlow = function(base, pow){
  if (pow === 0){
    return 1;
  } else {
    return expSlow(base, pow-1) * base;
  }
};

// console.log(exp_slow(2,5));

var expFast = function(base, pow){
  if (pow === 0){
    return 1;
  } else if (pow === 1) {
    return base;
  } else if (pow % 2 === 0) {
    return expFast(base, pow/2) * expFast(base, pow/2);
  } else {
    return base * expFast(base, (pow-1)/2) * expFast(base, (pow-1)/2);
  }
};

// console.log(exp_fast(2,10));

var fib = function(n){
  if (n === 1){
    return [1];
  } else if (n === 2) {
    return [1, 1];
  } else {
    var prevFibs = fib(n-1); //[1,1,2]
    prevFibs.push(prevFibs[prevFibs.length - 2] + prevFibs[prevFibs.length - 1]);
    return prevFibs;
  }
};

// console.log(fib(5));

var bsearch = function(array, target) {
  var midIndex = parseInt(array.length / 2);
  if (array.length === 0) {
    return null;
  }
  if (array[midIndex] === target) {
    return midIndex;
  } else if (target < array[midIndex]){
    return bsearch(array.slice(0, midIndex), target);
  } else {
    var rightIndex = bsearch(array.slice(midIndex + 1, array.length), target);
    return rightIndex !== null ? (midIndex + 1 + rightIndex) : null;
  }
};

// console.log(bsearch([1,2,3,4,5], 1));

var makeChange = function(total, coins){
  if (total === 0) {
    return [];
  } else if (Math.min.apply(null, coins) > total) {
    return null;
  } else {
    coins = coins.sort(function(a, b) { return b-a });
    var bestChange = null;
    
    for (var i = 0; i < coins.length; i++) {
      if (coins[i] > total) continue; 
      var remainder = total - coins[i];
      var bestRemainder = makeChange(remainder, coins.slice(i, coins.length));
      if (bestRemainder === null) continue;
      var thisChange = [coins[i]].concat(bestRemainder);
      if (bestChange === null || ( thisChange.length < bestChange.length)) {
        var bestChange = thisChange;
      }
    }
    return bestChange;
  } 
};

// console.log(makeChange(14, [10,7,1]));

var mergeSort = function(array) {
  if (array.length === 0 || array.length === 1) {
    return array;
  } else {
    var midIndex = parseInt(array.length/2);
    return merge(
      mergeSort(array.slice(0, midIndex)),
      mergeSort(array.slice(midIndex, array.length))
    );
  }
};

var merge = function(left, right) {
  var output = [];
  while (left.length && right.length) {
    if (left[0] < right[0]) {
      output.push(left.shift());
    } else {
      output.push(right.shift());
    }
  }
  return output.concat(left).concat(right);
}

console.log(mergeSort([3,41,1,0,45,2,90]))

