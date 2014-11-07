var HanoiGame = function() {
  this.towers = [[3,2,1],[],[]];
};

HanoiGame.prototype.isWon = function() {
  console.log('iswon');
  console.log(this.towers);
  for (var i = 1; i < 3; i++) {
    if (this.towers[i].length === 3) { //assume 3 disks in game
      return true;
    }
  }
  return false;
}

HanoiGame.prototype.isValidMove = function(startTowerIdx, endTowerIdx) {
  if (this.towers[startTowerIdx].length === 0) {
    return false; //trying to move from an empty tower
  } else if (this.towers[endTowerIdx].length === 0) {
    return true;
  } else if (this.towers[startTowerIdx].slice(-1) < 
                                          this.towers[endTowerIdx].slice(-1)) {
    return true;
  }
}

HanoiGame.prototype.move = function(startTowerIdx, endTowerIdx) {
  if (this.isValidMove(startTowerIdx, endTowerIdx)) {
    disk = this.towers[startTowerIdx].pop();
    this.towers[endTowerIdx].push(disk);
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.print = function() {
  console.log(JSON.stringify(this.towers));
};


var readline = require("readline");

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

HanoiGame.prototype.promptMove = function(callback) {
  this.print;

  reader.question("Start tower: ", function (startTowerInput) {
    reader.question("End tower: ", function (endTowerInput) {
      var startTowerIdx = parseInt(startTowerInput);
      var endTowerIdx = parseInt(endTowerInput);

      callback(startTowerIdx, endTowerIdx);
    });
  });
};

HanoiGame.prototype.run = function(completionCallback) {
  this.print();
  game = this;
  game.promptMove(function (startTowerIdx, endTowerIdx) {
    if (game.move(startTowerIdx, endTowerIdx)) {
      if (game.isWon()) {
        console.log('you won');
        completionCallback();
      }
      else {
        game.run(completionCallback);
      }
    } else {
      console.log('could not make move');
      completionCallback();
    }
  });
};

var hg = new HanoiGame();
console.log(hg.towers);
hg.run(function () {
  reader.close();
});