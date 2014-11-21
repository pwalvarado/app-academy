NewsReader.Views.FeedShow = Backbone.View.extend({
  initialize: function () {
    this.listenTo(this.model, 'sync', this.render)
  },
  
  events: {
    "click #refresh": "refresh",
    "click #back": function () {
      Backbone.history.navigate("#/", {trigger: true});
    }
  },
  
  refresh: function () {
    this.model.fetch();
    this.render();
  },
  
  render: function () {
    this.$el.html(JST['feeds/back_to_feeds']());
    var content;
    var firstModelAttrs = this.model.entries().models[0].attributes;
    if (this.model.entries() && !$.isEmptyObject(firstModelAttrs)) {
      content = this.template({ 
        feed: this.model, 
        entries: this.model.entries().models.sort(function(a, b){return Date.parse(b.get('published_at')) - Date.parse(a.get('published_at'))})
      });
    } else {
      content = JST['entries/loading']();
    }
    
    this.$el.append(content);
    return this;
  },
  
  template: JST['feeds/show']
});