NewsReader.Views.FormView = Backbone.View.extend({
  events: {
    "submit form": "saveFeed"
  },
  
  render: function () {
    var content = this.template({ feed: this.model });
    this.$el.html(content);
    return this;
  },
  
  saveFeed: function (event) {
    event.preventDefault();
    var attributes = $(event.currentTarget).serializeJSON();
    this.model.save(attributes, {
      success: function() {
        this.model = new NewsReader.Models.Feed();
      }.bind(this)
    });
    
    _feeds.add(this.model);
  },
  
  template: JST['feeds/feed_form']
});