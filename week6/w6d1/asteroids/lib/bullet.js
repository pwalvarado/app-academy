(function(){
  if (typeof(Asteroids) == "undefined"){
    window.Asteroids = {};
  }
  
  var MovingObject = window.Asteroids.MovingObject;
  
  var Bullet = window.Asteroids.Bullet = function(bulletParam){
    MovingObject.call(this,
                      {
                      pos: bulletParam.pos, 
                      vel: bulletParam.vel,
                      radius: Bullet.RADIUS,
                      color: Bullet.COLOR,
                      game: bulletParam.game
                      })
    var norm = this.vel.norm();
    this.vel = [this.vel[0]*Bullet.FACTOR/norm, this.vel[1]*Bullet.FACTOR/norm] // factor out
  }
  Bullet.inherits(MovingObject)
  
  Bullet.prototype.isWrappable = false;
  
  Bullet.prototype.collideWith = function (otherObject){
    this.game.remove(this);
    
    if (otherObject instanceof window.Asteroids.Ship) {
      return;
    } else {
      this.game.remove(otherObject);
    }
  }
  
  Bullet.COLOR = '#FF0000';
  Bullet.RADIUS = 3;
  Bullet.FACTOR = 10;
})();