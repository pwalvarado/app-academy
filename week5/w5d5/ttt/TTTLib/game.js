var Board = require("./board");

var Game = function(reader, endOfGameCallback) {
  this.reader = reader;
  this.endOfGameCallback = endOfGameCallback;
  this.board = new Board();
  this.turnsPlayed = 0;
};

Game.prototype.currentPlayer = function() {
  return ['x', 'o'][this.turnsPlayed % 2];
};

Game.prototype.getMove = function(callback) {
  this.board.print();
  var game = this;
  game.reader.question("Enter your move as row & column: ", function (moveString) {
    game.parseMoveString(moveString, callback);
  });
};

Game.prototype.parseMoveString = function(moveString, callback) {
  var pos = [parseInt(moveString[0]), parseInt(moveString[1])];
  this.makeMove(pos, callback);
};

Game.prototype.makeMove = function(pos, callback) {
  this.board.place_mark(pos, this.currentPlayer());
  callback();
};

Game.prototype.run = function() {
  var game = this;
  game.getMove(function () {
    if (!game.board.isWon()) {
      game.turnsPlayed++;
      game.run();
    } else {
      game.board.print();
      winner = game.currentPlayer();
      console.log('the winner is ' + winner);
      game.endOfGameCallback();
    }
  })
};

module.exports = Game;