(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $board) {
    this.game = game;
    this.$board = $board;
    this.setupBoard();
    this.bindEvents();
  };

  View.prototype.bindEvents = function () {
    var that = this;
    $('.cell').on('click', function(event){ 
      that.makeMove($(event.currentTarget)) 
    });
  };

  View.prototype.makeMove = function ($square) {
    var pos = $square.data('pos');
    var color = (this.game.currentPlayer === 'x' ? 'red' : 'blue')
    this.game.playMove(pos);
    $square.css('background', color);
    this.alertWinner();
  };
  
  View.prototype.alertWinner = function () {
    if(this.game.isOver()) {
      var winner = this.game.winner();
      if (winner) {
        var winnerColor = (winner === 'x' ? 'red' : 'blue')
        alert(winnerColor + " has won!");
      } else {
        alert('Tie!');
      }
    }
  }

  View.prototype.setupBoard = function () {
    var divString = ""
    divString += "<div class='row'>"
    divString += "<div class='cell' data-pos='[0,0]'></div>"
    divString += "<div class='cell' data-pos='[0,1]'></div>"
    divString += "<div class='cell' data-pos='[0,2]'></div>"
    divString += "</div>"
    divString += "<div class='row'>"
    divString += "<div class='cell' data-pos='[1,0]'></div>"
    divString += "<div class='cell' data-pos='[1,1]'></div>"
    divString += "<div class='cell' data-pos='[1,2]'></div>"
    divString += "</div>"
    divString += "<div class='row'>"
    divString += "<div class='cell' data-pos='[2,0]'></div>"
    divString += "<div class='cell' data-pos='[2,1]'></div>"
    divString += "<div class='cell' data-pos='[2,2]'></div>"
    divString += "</div>"
    this.$board.html(divString);
  };
})();
