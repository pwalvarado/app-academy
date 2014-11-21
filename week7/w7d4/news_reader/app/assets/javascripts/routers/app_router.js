NewsReader.Routers.AppRouter = Backbone.Router.extend({
  initialize: function ($rootEl) {
    this.$rootEl = $rootEl;
  },
  
  routes: {
    "": "feedIndex",
    "feeds/:id": "feedShow"
  },

  feedIndex: function() {
    _feeds.fetch();
    var feedIndexView = new NewsReader.Views.FeedsIndex({ collection: _feeds });
    this.$rootEl.html(feedIndexView.render().$el);
  },
  
  feedShow: function (id) {
    var feed = _feeds.getOrFetch(id);
    var showView = new NewsReader.Views.FeedShow({ model: feed });
    this.$rootEl.html(showView.render().$el);
  }
});
