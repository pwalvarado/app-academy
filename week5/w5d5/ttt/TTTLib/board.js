var Board = function() {
  this.grid = [[null, null, null],[null, null, null],[null, null, null]];
};

Board.prototype.print = function() {
  console.log(this.grid[0]);
  console.log(this.grid[1]);
  console.log(this.grid[2]);
};

Board.prototype.isWon = function() {
  //rows
  var grid = this.grid;

  return (
    grid[0][0] && grid[0][0] === grid[0][1] && grid[0][1] === grid[0][2] ||
    grid[1][0] && grid[1][0] === grid[1][1] && grid[1][1] === grid[1][2] ||
    grid[2][0] && grid[2][0] === grid[2][1] && grid[2][1] === grid[2][2] ||

    //cols
    grid[0][0] && grid[0][0] === grid[1][0] && grid[1][0] === grid[2][0] ||
    grid[0][1] && grid[0][1] === grid[1][1] && grid[1][1] === grid[2][1] ||
    grid[0][2] && grid[0][2] === grid[1][2] && grid[1][2] === grid[2][2] ||

    //diags
    grid[0][0] && grid[0][0] === grid[1][1] && grid[1][1] === grid[2][2] ||
    grid[0][2] && grid[0][2] === grid[1][1] && grid[1][1] === grid[2][0]
  ) ;
};

Board.prototype.isEmpty = function(pos) {
  var row = pos[0];
  var col = pos[1];
  return this.grid[row][col] === null;  
};

Board.prototype.place_mark = function(pos, mark) {
  var row = pos[0];
  var col = pos[1];
  this.grid[row][col] = mark;
};

module.exports = Board;