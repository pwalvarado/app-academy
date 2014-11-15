// Follow Toggle //
$.FollowToggle = function (el, options) {
  this.$el = $(el);
  this.userId = this.$el.data('user-id') || options.userId;
  this.followState = this.$el.data('initial-follow-state') || options.followState;
  this.render();
  this.$el.on('click', this.handleClick.bind(this));
};

$.FollowToggle.prototype.render = function () {
  var buttonText;
  if (this.followState === 'unfollowed') {
    buttonText = 'Follow!';
    this.$el.prop('disabled', false);
  } else if (this.followState === 'followed') {
    buttonText = 'Unfollow!';
    this.$el.prop('disabled', false);
  } else if (this.followState === 'following') {
    this.$el.prop('disabled', true);
  } else if (this.followState === 'unfollowing') {
    this.$el.prop('disabled', true);
  }
  this.$el.html(buttonText);
};

$.FollowToggle.prototype.handleClick = function (event) {
  event.preventDefault();
  var method = (this.followState === 'unfollowed') ? 'POST' : 'DELETE';
  this.followState = (this.followState === 'unfollowed') ? 'following' : 'unfollowing';
  this.render();
  $.ajax({
    url: "/users/" + this.userId + "/follow",
    type: method,
    dataType: 'json',
    success: function (returnData) {
      this.followState = (this.followState === 'unfollowing') ? 'unfollowed' : 'followed';
      this.render();
    }.bind(this)
  });
};

$.fn.followToggle = function (options) {
  return this.each(function () {
    new $.FollowToggle(this, options);
  });
};

$(function () {
  $("button.follow-toggle").followToggle();
});

// UsersSearch //

$.UsersSearch = function (el) {
  this.$el = $(el);
  this.$usersList = $('ul.users');
  this.$usersSearch = $('input#name');
  this.$el.on('input', this.handleInput.bind(this));
};

$.UsersSearch.prototype.renderResults = function (matchingUsers) {
  this.$usersList.empty();
  $(matchingUsers).each(function (index, user) {
    var $link = $("<a href='/users/" + user.id + "'>").html(user.username);
    var $li = $('<li>');
    var followState = (user.followed) ? 'followed' : 'unfollowed'; 
    $li.append($link);
    $li.append($('<button>').followToggle({userId: user.id, followState: followState}));
    this.$usersList.append($li);
  }.bind(this));
};

$.UsersSearch.prototype.handleInput = function (event) {
  event.preventDefault();
  $.ajax({
    url: "/users/search",
    type: 'GET',
    dataType: 'json',
    data: {
      query: this.$usersSearch.val()
    },
    success: function (matchingUsers) {
      this.renderResults(matchingUsers);
    }.bind(this)
  });
};

$.fn.usersSearch = function () {
  return this.each(function () {
    new $.UsersSearch(this);
  });
};

$(function () {
  $("div.users-search").usersSearch();
});

// TweetCompose //

$.TweetCompose = function(el) {
  this.$el = $(el);
  this.$content = $('#tweet-content');
  this.$mentionedUser = $('#mentioned-user');
  this.$el.on('submit', this.submit.bind(this));
  $('#tweet-content').on('input', this.updateCharsLeft.bind(this));
};

$.TweetCompose.prototype.submit = function (event) {
  event.preventDefault();
  var serializedTweet = this.$el.serializeJSON();
  $(':input').prop('disabled', true);
  $.ajax({
    url: "/tweets",
    type: 'POST',
    dataType: 'json',
    data: serializedTweet,
    success: this.handleSuccess.bind(this)
  });
};

$.TweetCompose.prototype.handleSuccess = function () {
  $(':input').prop('disabled', false);
  this.clearInput();
};

$.TweetCompose.prototype.clearInput = function(){
  $('#tweet-content').val("");
  $(':input#mentioned-user-ids :first-child').prop('selected', true);
}

$.TweetCompose.prototype.updateCharsLeft = function () {
  var charsUsed = $('#tweet-content').val().length;
  var charsLeft = Math.max(140 - charsUsed, 0);
  $('.chars-left').html(charsLeft);
};

$.fn.tweetCompose = function () {
  return this.each(function () {
    new $.TweetCompose(this);
  });
};


$(function () {
  $("form.tweet-compose").tweetCompose();
});
