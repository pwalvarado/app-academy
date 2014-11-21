NewsReader.Views.FeedsIndex = Backbone.View.extend({
  initialize: function () {
    this.addFormView();
    this.listenTo(this.collection, 'sync remove add', function () {
        this.addSubviews();
        this.render(true);
      }.bind(this)
    );
  },
  
  addFormView: function () {
    var newFeed = new NewsReader.Models.Feed();
    this._formView = new NewsReader.Views.FormView({ model: newFeed });
  },
  
  addSubviews: function () {
    this.feedItems = [];
    this.collection.each(function (feed) {
      var feedItem = new NewsReader.Views.feedItem({ model: feed });
      this.feedItems.push(feedItem.render());
    }.bind(this));
    this.collection.models.sort(function (a,b) {
      return Date.parse(a.attributes.created_at) - Date.parse(b.attributes.created_at);
    });
  },
  
  attachFormView: function () {
    this.$el.append(this._formView.render().$el);
    this._formView.delegateEvents();
  },
  
  attachSubviews: function () {
    var $ul = $('<ul class="list-unstyled">');
    this.feedItems.forEach(function(feedItem) {
      if (feedItem.model.id) {
        $ul.append(feedItem.render().$el);
      }
    });
    this.$el.append($ul);
  },
  
  render: function (fetch_complete) {
    this.$el.empty();
    this.$el.append(JST['feeds/header']());
    if (this.feedItems && this.feedItems.length > 0) {
      this.attachSubviews();
    } else if (!fetch_complete) {
      this.$el.append(JST['feeds/loading']());
    } else {
      this.$el.append(JST['feeds/no_feeds']());
    }
    this.attachFormView();
    return this;
  },
  
  template: JST['feeds/index']
});
