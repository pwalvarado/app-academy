NewsReader.Views.feedItem = Backbone.View.extend({
  events: {
    "click .delete-feed": "destroy"
  },
  
  destroy: function() {
    this.model.destroy();
  },
  
  render: function () {
    var content = this.template({ entry: this.model });
    this.$el.html(content);
    return this;
  },
  
  template: JST['feeds/feed_item']
});