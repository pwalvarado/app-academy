NewReader.Collections.Entries = Backbone.Collection.extend({
  initialize: function(models, options) {
    this.feed = options.feed;
  },
  model: NewReader.Models.Entry,
  url: function() {
    return this.feed.url() + '/entries';
  },
  comparator: function(entry) {
    return entry.get('published_at');
  },
  getOrFetch: function(id) {
    var maybeEntry = this.get(id);
    if (!maybeEntry) {
      var that = this;
      maybeEntry = new NewReader.Models.Entry({
        id: id
      });
      maybeEntry.fetch({
        success: function() {
          that.add(maybeEntry);
        }
      });
    }
    return maybeEntry;
  }
});
