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

Game.prototype.playTurn = function(callback) {
  this.getMove(callback);
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

Game.prototype.handleWin = function() {
  this.board.print();
  winner = this.currentPlayer();
  console.log('the winner is ' + winner);
  this.endOfGameCallback();
};

Game.prototype.handleDraw = function() {
  this.board.print();
  console.log('the game was a draw');
  this.endOfGameCallback();
};

Game.prototype.run = function() {
  var game = this;
  game.playTurn(function () {
    if (game.board.isWon()) {
      game.handleWin();
    } else if (game.board.isDrawn()) {
      game.handleDraw();
    }
    else {
      game.turnsPlayed++;
      game.run();
    }
  });
};

module.exports = Game;
