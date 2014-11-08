var TTT = require("./TTTLib"); 

var readline = require("readline");
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var game = new TTT.Game(reader, function () {
  reader.close();
});

game.run();