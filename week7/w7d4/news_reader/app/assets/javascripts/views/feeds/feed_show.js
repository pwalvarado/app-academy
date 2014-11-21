NewsReader.Views.FeedShow = Backbone.View.extend({
  initialize: function () {
    this.listenTo(this.model, 'sync', this.render)
  },
  
  events: {
    "click #refresh": "refresh"
  },
  
  refresh: function () {
    this.model.fetch();
  },
  
  render: function () {
    var content = this.template({ 
      feed: this.model, 
      entries: this.model.entries() 
    });
    
    this.$el.html(content);
    return this;
  },
  
  template: JST['feeds/show']
});