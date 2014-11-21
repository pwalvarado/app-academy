NewsReader.Collections.Entries = Backbone.Collection.extend({
  model: NewsReader.Models.Entry,
  url: function () {
    return this.feed.url() + '/entries';
  }
});
