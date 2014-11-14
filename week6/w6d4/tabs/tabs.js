$.Tabs = function (el) {
  this.$el = $(el);
  this.$activeLink = $(this.$el.find('.active'));
  this.$contentPanes = $(this.$el.data('content-tabs'));
  this.$activePane = this.$contentPanes.find('.active');
  this.$el.on('click', 'a', this.clickLink.bind(this));
};

$.Tabs.prototype.clickLink = function (event) {
  event.preventDefault();
  var $clickedLink = $(event.currentTarget);
  $clickedLink.addClass('active');
  this.$activeLink.removeClass('active');
  var paneToActivate = this.$contentPanes.find($clickedLink.attr('href'));
  this.$activePane.toggleClass('active transitioning');
  // this.$activeLink.addClass('transitioning');
  this.$activePane.one('transitionend', function(){
    this.$activePane.removeClass('transitioning');
    paneToActivate.addClass('active transitioning');
    setTimeout(function() {
      paneToActivate.removeClass("transitioning");
    }.bind(this), 0);
    this.$activePane = paneToActivate;
    this.$activeLink = $clickedLink;
  }.bind(this))
  
};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
