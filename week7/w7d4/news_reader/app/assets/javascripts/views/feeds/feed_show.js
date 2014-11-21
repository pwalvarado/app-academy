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
    var content;
    var firstModelAttrs = this.model.entries().models[0].attributes;
    if (this.model.entries() && !$.isEmptyObject(firstModelAttrs)) {
      content = this.template({ 
        feed: this.model, 
        entries: this.model.entries() 
      });
    } else {
      content = JST['entries/loading']();
    }
    
    this.$el.html(content);
    return this;
  },
  
  template: JST['feeds/show']
});