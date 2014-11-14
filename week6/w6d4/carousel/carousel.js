$.Carousel = function (el) {
  this.$el = $(el);
  this.activeIdx = 0;
  this.numImages = $('.carousel .items img').length;
  $('div.items :first-child').addClass('active');
  $('.slide-left').on('click', this.slideLeft.bind(this));
  $('.slide-right').on('click', this.slideRight.bind(this));
  
};

$.Carousel.prototype.slide = function (idxDiff) {
  if (this.transitioning === true) {
    return;
  }
  this.transitioning = true;
  var outgoingClass = ((idxDiff === 1) ? "left" : "right");
  var $formerlyActive = $('.carousel .items img').eq(this.activeIdx);
  $formerlyActive.addClass(outgoingClass);
  $formerlyActive.one('transitionend', function(){
    $formerlyActive.removeClass('active ' + outgoingClass);
    this.transitioning = false;
  }.bind(this));
  this.activeIdx = (this.activeIdx += idxDiff) % this.numImages;
  var $newlyActive = $('.carousel .items img').eq(this.activeIdx).addClass('active');
  var incomingClass = ((idxDiff === -1) ? "left" : "right");
  $newlyActive.addClass(incomingClass);
  setTimeout(function(){
    $newlyActive.removeClass(incomingClass);
  }, 0);
};

$.Carousel.prototype.slideLeft = function(event){
  this.slide(1);
};

$.Carousel.prototype.slideRight = function(event){
  this.slide(-1);
};


$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};
