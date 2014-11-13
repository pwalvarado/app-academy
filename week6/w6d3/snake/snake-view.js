(function () {
  if (typeof Worm === "undefined") {
    window.Worm = {};
  }
  
  var View = Worm.View = function ($board) {
    this.$board = $board;
    this.board = new Worm.Board();
    this.$board.html(this.board.render());
    $(document).on('keydown', this.handleKeyEvent.bind(this));
   
  };
  
  View.prototype.start = function () {
     return setInterval(this.step.bind(this), 90);
  }
  
  View.prototype.handleKeyEvent = function (event) {
    var keyCode = event.keyCode;
    if ([37, 38, 39, 40].indexOf(keyCode) !== -1) {
      this.board.snake.turn(View.KEYS[event.keyCode]);
    }
  }
  
  View.prototype.step = function () {
    this.board.snake.move();
    $('#length').html(this.board.snake.segments.length);
    this.$board.html(this.board.render());
  } 
  
  View.KEYS = {
    37: 'W',
    38: 'N',
    39: 'E',
    40: 'S'
  }
})();  