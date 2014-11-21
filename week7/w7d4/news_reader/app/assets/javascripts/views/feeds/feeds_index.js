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
    this.entryViews = [];
    this.collection.each(function (entry) {
      var entryView = new NewsReader.Views.Entry({ model: entry });
      this.entryViews.push(entryView.render());
    }.bind(this));
  },
  
  attachFormView: function () {
    this.$el.append(this._formView.render().$el);
    this._formView.delegateEvents();
  },
  
  attachSubviews: function () {
    var $ul = $('<ul class="list-unstyled">');
    this.entryViews.forEach(function(entryView) {
      if (entryView.model.id) {
        $ul.append(entryView.render().$el);
      }
    });
    this.$el.append($ul);
  },
  
  render: function (fetch_complete) {
    this.$el.empty();
    this.$el.append(JST['feeds/header']());
    if (this.entryViews && this.entryViews.length > 0) {
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
