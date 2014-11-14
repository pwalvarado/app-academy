$.Thumbnails = function (el) {
  this.$el = $(el);
  this.gutterIdx = 0;
  this.$images = $('.thumbnails .gutter-images img');
  this.fillGutterImages();
  this.$activeImage = $('div.gutter-images :first-child');
  this.activate(this.$activeImage);
  $('.gutter-images').on('mouseenter', 'img', function () {
    this.activate($(event.target));
  }.bind(this));
  $('.gutter-images').on('mouseleave', 'img', function () {
    this.activate(this.$activeImage);
  }.bind(this));
  $('.gutter-images').on('click', 'img', function () {
    this.$activeImage = $(event.target);
  }.bind(this));
};

$.Thumbnails.prototype.activate = function ($img) {
  var $ImageClone = $img.clone();
  $('.thumbnails .active img').replaceWith($ImageClone);
};

$.Thumbnails.prototype.fillGutterImages = function() {
  var $gutterImages = $('.gutter-images').empty();
  var gutterIndex = this.gutterIdx; 
  this.$images.each(function(index){
    if (index >= gutterIndex && index < gutterIndex + 5){
      $gutterImages.append(this);
    } 
  });
};

$.fn.thumbnails = function () {
  return this.each(function () {
    new $.Thumbnails(this);
  });
};
