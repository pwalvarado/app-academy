(function(){
  if (typeof(Asteroids) == "undefined"){
    window.Asteroids = {};
  }
  
  var MovingObject = window.Asteroids.MovingObject;
  
  var Asteroid = window.Asteroids.Asteroid = function(asteroidParam){
    MovingObject.call(this, {
      pos: asteroidParam.pos, 
      vel: window.Asteroids.Util.randomVec(Math.random() + 0.5),
      radius: Asteroid.RADIUS,
      color: Asteroid.COLOR,
      game: asteroidParam.game
    });
  };
  
  Asteroid.inherits(MovingObject)
  
  Asteroid.prototype.collideWith = function (otherObject){
    this.game.remove(this);
    if (otherObject instanceof window.Asteroids.Ship) {
      this.game.ship.regenerate();
    } else {
      this.game.remove(otherObject);
    }
  };
  
  Asteroid.COLOR = '#000000';
  Asteroid.RADIUS = 22;
})();