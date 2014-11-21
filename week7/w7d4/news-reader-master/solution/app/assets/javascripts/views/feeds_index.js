NewReader.Views.FeedsIndex = Backbone.View.extend({
  template: JST['feeds/index'],
  tagName: 'ul',
  className: 'feeds-index',

  initialize: function() {
    this.listenTo(this.collection, 'sync add', this.render);
  },

  events: {
    'click .add-button': 'addFeed'
  },

  render: function() {
    var that = this;
    that.$el.html(that.template({
      feeds: that.collection
    }));
    return this;
  },

  addFeed: function(event) {
    event.preventDefault();
    var newUrl = this.$('input').val();
    var that = this;
    var newFeed = new NewReader.Models.Feed({
      'url': newUrl
    });
    newFeed.save({}, {
      success: function() {
        that.collection.add(newFeed);
      }
    })
  }
});
