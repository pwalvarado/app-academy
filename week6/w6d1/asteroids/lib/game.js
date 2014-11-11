(function(){
  if (typeof(Asteroids) == "undefined"){
    window.Asteroids = {};
  }
  
  var Game = window.Asteroids.Game = function(){
    this.asteroids = [];
    this.bullets = [];
    this.addAsteroids();
    this.ship = this.createShip();    
  };
  
  Game.prototype.createShip = function(){
    return new window.Asteroids.Ship({ 
      pos: Game.prototype.startingShipPos(), 
      game: this
    });
  };
  
  Game.prototype.addAsteroids = function(){
    while (this.asteroids.length < Game.NUM_ASTEROIDS) {
      //console.log(new window.Asteroids.Asteroid({pos: Game.randomPosition()}))
      this.asteroids.push(new window.Asteroids.Asteroid({ 
        pos: Game.prototype.randomPosition(), 
        game: this
      }));
    }
  };
  
  Game.prototype.addBullets = function(bullet){
    this.bullets.push(bullet);
  };
  
  Game.prototype.randomPosition = function(){
    return [Math.random() * Game.DIM_X, Math.random() * Game.DIM_Y];
  };
  
  Game.prototype.draw = function (ctx) {
    
    ctx.clearRect(0,0, Game.DIM_X, Game.DIM_Y);
    ctx.drawImage(img, 0, 0, 700, 500)
    for(var i = 0; i < this.allObjects().length; i++){
      this.allObjects()[i].draw(ctx);
    }
  }
  
  Game.prototype.moveObjects = function(){
    for(var i = 0; i < this.allObjects().length; i++){
      this.allObjects()[i].move();
    }
  }
  
  Game.prototype.checkCollisions = function(){
    for(var i = 0; i < this.asteroids.length; i++){
      for(var j = 0; j < this.allObjects().length; j++){
        if(!this.asteroids[i]) {
          return;
        }
        if(i !== j) {
          if (this.asteroids[i].isCollidedWith(this.allObjects()[j])){
            this.asteroids[i].collideWith(this.allObjects()[j])
          }
        }
      }
    }
  } 
  
  Game.prototype.remove = function(obj){
    if (obj instanceof window.Asteroids.Asteroid){
      this.asteroids.splice(this.asteroids.indexOf(obj), 1);
    } else if (obj instanceof window.Asteroids.Bullet){
      this.bullets.splice(this.bullets.indexOf(obj), 1)
    }
  }
  
  Game.prototype.step = function(){
    this.moveObjects();
    this.checkCollisions();
  }
  
  Game.prototype.wrap = function(pos){
    var x = pos[0];
    var y = pos[1];
    if (x >= Game.DIM_X){
      x = x - Game.DIM_X;
    } else if (x < 0) {
      x = x + 600
    }
    if ( y >= Game.DIM_Y) {
      y = y - Game.DIM_Y
    } else if (y < 0) {
      y = y + Game.DIM_Y
    }
    return [x, y];
  }
  
  Game.prototype.allObjects = function () {
    return this.asteroids.concat(this.bullets).concat([this.ship]);
  }
  
  Game.prototype.isOutOfBounds = function(pos){
    var x = pos[0];
    var y = pos[1];
    return x < 0 || x >= Game.DIM_X || y < 0 || y >= Game.DIM_Y;
  }
  
  Game.prototype.startingShipPos = function () {
    return [Game.DIM_X/2, Game.DIM_Y/2];
  }
  
  Game.prototype.restart = function () {
    if (this.asteroids.length === 0) {
      this.asteroids = [];
      this.bullets = [];
      this.addAsteroids();
      this.ship = this.createShip(); 
    }
  };
  
  Game.prototype.checkOver = function (ctx) {
    if (this.asteroids.length === 0) {
      var text = 'You Won! R to restart.';
      ctx.font = '50pt Arial';
      ctx.fillStyle = '#FFFFFF';
      ctx.fillText(text,
        Game.DIM_X / 2 - ctx.measureText(text).width / 2,
        Game.DIM_Y / 2
      )
    }
  };
  
  Game.DIM_X = 700;
  Game.DIM_Y = 500;
  Game.NUM_ASTEROIDS = 20;

})();