Function.prototype.inherits = function(parentClass){
  function Surrogate(){};
  Surrogate.prototype = parentClass.prototype;
  this.prototype = new Surrogate();
}


function MovingObject(){

}

MovingObject.prototype.moveup = function(){
  console.log("moved up")
}
function Ship(){};
Ship.inherits(MovingObject);
Ship.prototype.movedown = function(){
  console.log("moved down")
}

var auster = new Ship();
auster.movedown();
auster.moveup();
var david = new MovingObject();
david.movedown();