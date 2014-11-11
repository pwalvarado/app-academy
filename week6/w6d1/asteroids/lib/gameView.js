(function(){
  if (typeof(Asteroids) == "undefined"){
    window.Asteroids = {};
  }
  
  var GameView = window.Asteroids.GameView = function(game, ctx) {
    this.game = game;
    this.ctx = ctx;
  };
  
  GameView.prototype.start = function(){
    var that = this;
    window.setInterval(function(){
      that.game.step();
      that.game.draw(that.ctx);
      that.game.checkOver(that.ctx);
    }, 20);
    
    key('up', function(){ that.game.ship.power([0,-1]) });
    key('down', function(){ that.game.ship.power([0,1]) });
    key('right', function(){ that.game.ship.power([1,0]) });
    key('left', function(){ that.game.ship.power([-1,0]) });
    key('space', function(){ that.game.ship.fireBullet()});
    key('r', function(){ that.game.restart()});
  };
  
})();