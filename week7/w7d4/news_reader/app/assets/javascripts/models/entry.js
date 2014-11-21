NewsReader.Models.Entry = Backbone.Model.extend({
  rootUrl: function () {
    return this.feed.url() + '/entries'
  }
});
