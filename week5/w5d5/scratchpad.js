var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumbers(sum, numsLeft, completionCallback){
  if (numsLeft > 0) {
    reader.question("Next number to add:", function (number, num2) {
      num2 = 9;
      console.log('number:' + number + num2);
      reader.close();
    });
    numsLeft--;
  } else {
    completionCallback(sum);
  }
};

addNumbers(0, 3, function (sum) {
  console.log("Total Sum: " + sum);
});