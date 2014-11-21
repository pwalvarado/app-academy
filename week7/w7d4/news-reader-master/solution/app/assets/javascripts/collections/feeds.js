NewReader.Collections.Feeds = Backbone.Collection.extend({
  model: NewReader.Models.Feed,
  url: 'api/feeds',
  getOrFetch: function(id) {
    var feedMaybe = this.get(id);
    if (!feedMaybe) {
      feedMaybe = new NewReader.Models.Feed({
        id: id
      });
      var that = this;
      feedMaybe.fetch({
        success: function() {
          that.add(feedMaybe);
        }
      });
    }
    return feedMaybe;
  }
});
