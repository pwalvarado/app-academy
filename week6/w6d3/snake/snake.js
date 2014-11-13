(function () {
  if (typeof Worm === "undefined") {
    window.Worm = {};
  }
  
  var Snake = Worm.Snake = function (board) {
    this.dir = "N";
    this.segments = [[12, 9], [11, 9], [10, 9]];
    this.turnsSinceEatingApple = 4;
    this.board = board;
  };
  
  Snake.nextPos = function(pos, diff){
    var newRow = pos[0] + diff[0];
    if(newRow < 0){
      newRow += Worm.Board.ROWS;
    } else if (newRow > Worm.Board.ROWS - 1){
      newRow -= Worm.Board.ROWS;
    }   
    
    var newCol = pos[1] + diff[1];
    if(newCol < 0){
      newCol += Worm.Board.COLS;
    } else if (newCol > Worm.Board.COLS - 1){
      newCol -= Worm.Board.COLS;
    }   
    
    return [newRow, newCol];
  };
  
  Snake.prototype.move = function(){
    if (this.turnsSinceEatingApple > 2){
      this.segments.shift();
    } else {
      this.turnsSinceEatingApple++;
    }
    
    var newSegment = Snake.nextPos(
      this.segments.slice(-1)[0],
      Snake.DIFFS[this.dir]
    );
    if (newSegment[0] === this.board.apple[0] && 
      newSegment[1] === this.board.apple[1]) {
        this.turnsSinceEatingApple = 0;
        this.board.apple = this.board.randomApple();
    } else if (this.containsPos(newSegment)){
      alert("You Lose!");
      over();
    }
    
    this.segments.push(newSegment);
  };
  
  Snake.DIFFS = {
    'N': [-1, 0],
    'E': [0, 1],
    'S': [1, 0],
    'W': [0, -1]
  };

  Snake.prototype.turn = function (newDir) {
    this.dir = newDir;
  };
  
  Snake.prototype.containsPos = function (pos) {
    for (var i = 0; i < this.segments.length; i++) {
      if (this.segments[i][0] === pos[0] && this.segments[i][1] === pos[1]) {
        return true;
      }
    }
    return false;
  };

})();