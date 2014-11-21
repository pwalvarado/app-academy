NewsReader.Collections.Feeds = Backbone.Collection.extend({
  model: NewsReader.Models.Feed,
  url: '/api/feeds',
  
  getOrFetch: function (id) {
    var feed = this.get(id);
    
    if (!feed) {
      feed = new NewsReader.Models.Feed({ id: id });
    }
    feed.fetch({
      success: function() { this.add(feed) }.bind(this)
    });
    return feed;
  },
  
});
