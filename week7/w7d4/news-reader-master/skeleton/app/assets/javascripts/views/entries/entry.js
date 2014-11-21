NewsReader.Views.Entry = Backbone.View.extend({
  events: {
    "click #delete": "destroy"
  },
  
  destroy: function() {
    this.model.destroy();
  },
  
  render: function () {
    var content = this.template({ entry: this.model });
    this.$el.html(content);
    return this;
  },
  
  template: JST['entries/entry']
});