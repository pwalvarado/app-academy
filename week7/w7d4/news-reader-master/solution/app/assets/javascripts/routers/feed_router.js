NewReader.Routers.FeedRouter = Backbone.Router.extend({
  initialize: function(feeds, $rootEl, $sidebar) {
    this.feeds = feeds;
    this.$rootEl = $rootEl;
  },

  routes: {
    '': 'index',
    'feeds/:id': 'show',
    'feeds/:feed_id/entries/:id': 'entry'
  },
  index: function() {
    this.$rootEl.empty();
  },
  show: function(id) {
    var feed = this.feeds.getOrFetch(id);
    var feedShowView = new NewReader.Views.FeedShow({
      model: feed
    });
    feed.fetch();

    this._swapView(feedShowView);
  },
  entry: function(feed_id, id) {
    var entry = this.feeds.getOrFetch(feed_id).entries().getOrFetch(id);
    var entryShowView = new NewReader.Views.EntryShow({
      model: entry
    });
    entry.fetch();
    this._swapView(entryShowView);
  },

  _swapView: function(view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
});
