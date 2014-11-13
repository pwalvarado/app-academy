(function () {
  if (typeof Worm === "undefined") {
    window.Worm = {};
  }
  
  var Board = Worm.Board = function () {
    this.snake = new Worm.Snake(this);
    this.apple = this.randomApple();
  };
  
  Board.prototype.randomApple = function (){
    var row = Math.floor(Math.random() * Board.ROWS);
    var col = Math.floor(Math.random() * Board.COLS);
    var applePos = [row, col];
    while(this.snake.containsPos(applePos)){
      row = Math.floor(Math.random() * Board.ROWS);
      col = Math.floor(Math.random() * Board.COLS);
      applePos = [row, col];
    }
    return applePos;
  }
  
  Board.prototype.render = function() {
    var display = "";
    for (var rowIdx = 0; rowIdx < Board.ROWS; rowIdx++) {
      for (var colIdx = 0; colIdx < Board.COLS; colIdx++) {
        if (this.snake.containsPos([rowIdx, colIdx])) {
          display += "<div class='snake'></div>";
        } else if(this.apple[0] === rowIdx && this.apple[1] === colIdx) {
          display += "<div class='apple'></div>";
        } else {
          display += "<div></div>";
        }
      }
    }
    return display;
  };
  

  
  Board.ROWS = 20;
  Board.COLS = 20;

})();