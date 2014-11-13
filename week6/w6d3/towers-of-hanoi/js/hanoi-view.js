(function () {
  if (typeof Hanoi === "undefined") {
    window.Hanoi = {};
  }

  var View = Hanoi.View = function (game, $towers) {
    this.game = game;
    this.$towers = $towers;
    this.render();
    this.bindEvents();
  };
  
  
  View.prototype.render = function() {
    var towersString = "";    
    for(var towerIdx = 0; towerIdx < 3; towerIdx++){
      towersString += "<div data-id='" + towerIdx + "' class='tower'>";
      for(var diskIdx = 2; diskIdx >= 0; diskIdx--){
        var diskValue = this.game.towers[towerIdx][diskIdx];
        var diskSize = ( diskValue === undefined ? 0 : diskValue ); 
        towersString += "<div class='disk-" + diskSize + "'></div>";
       }
      towersString += "</div>";  
    }
    this.$towers.html(towersString);
    
  };
  
  View.prototype.bindEvents = function () {
    var that = this;
    $('.tower').on('click', function(event){ 
      that.clickTower($(event.currentTarget)); 
    });
  };

  View.prototype.clickTower = function($tower) {
    if(this.fromTower === undefined){
      this.fromTower = $tower;
      $tower.toggleClass('selected');
    } else {
      this.toTower = $tower;
      var fromIdx = this.fromTower.data('id');
      var toIdx = this.toTower.data('id');
      if (!this.game.isValidMove(fromIdx, toIdx)) {
        alert('Invalid Move!');
      } else {
        this.game.move(fromIdx, toIdx);
        this.fromTower.toggleClass('selected');
      }
      this.fromTower = undefined;
      this.toTower = undefined;
      this.render();
      this.alertWin();
      this.bindEvents();
    }
  };
  
  View.prototype.alertWin = function () {
    if(this.game.isWon()) {
      alert("You won!");
    }
  };
})();
