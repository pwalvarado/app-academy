(function(){
  if (typeof(Asteroids) == "undefined"){
    window.Asteroids = {};
  }
  
  var MovingObject = window.Asteroids.MovingObject;
  
  var Ship = window.Asteroids.Ship = function(shipParam){
    MovingObject.call(this,
                      {
                      pos: shipParam.pos, 
                      vel: [0, 0],
                      radius: Ship.RADIUS,
                      color: Ship.COLOR,
                      game: shipParam.game
                      })
  }
  Ship.inherits(MovingObject)
  
  Ship.prototype.regenerate = function () {
    this.pos = this.game.startingShipPos();//this.game.startingShipPos();
    this.vel = [0, 0];
  }
  
  Ship.prototype.power = function(impulse){
    this.vel = this.vel.addVector(impulse);
  }
  
  Ship.prototype.fireBullet = function () {
    var bullet = new window.Asteroids.Bullet({pos: this.pos, vel: this.vel, game: this.game});
    this.game.addBullets(bullet);
  }
  
  Ship.RADIUS = 20;
  Ship.COLOR = '#5500FF';
})();