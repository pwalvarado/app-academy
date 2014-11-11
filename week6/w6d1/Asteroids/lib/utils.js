(function(){
  if (typeof(Asteroids) == "undefined"){
    window.Asteroids = {};
  }
  
  Function.prototype.inherits = function(parentClass){
    function Surrogate(){};
    Surrogate.prototype = parentClass.prototype;
    this.prototype = new Surrogate();
  }
  
  Array.prototype.addVector = function(vector){
    return [this[0] + vector[0], this[1] + vector[1]];
  }
  
  Array.prototype.distanceTo = function(vector){
    return Math.sqrt(Math.pow(vector[0] - this[0], 2) + Math.pow(vector[1] - this[1], 2))
  }
  
  Array.prototype.norm = function () {
    return Math.sqrt(Math.pow(this[0], 2) + Math.pow(this[1], 2))
  } 
  
  var Util = window.Asteroids.Util = function(){
  }
  
  Util.randomVec = function(speed){
    var x = Math.random() * speed;
    var y = Math.sqrt(Math.pow(speed, 2) - Math.pow(x, 2));
    if (Math.random() > 0.5){
      y = -1 * y;
    }
    if (Math.random() > 0.5){
      x = -1 * x;
    }
    return [x, y]
  }
  
})();
