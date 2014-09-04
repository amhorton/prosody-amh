Prosody.Views.VoteButtons = Backbone.View.extend({
  template: JST["votes/buttons"],

  initialize: function (options) {
    this.votableType = options.votableType;
  },

  events: {
    'click .inactive': 'vote'
  },

  render: function () {
    var renderedContent = this.template({
      votable: this.model
    });

    this.$el.html(renderedContent);

    if (!this.model.get("can_upvote")) {
      this.$('.up').removeClass("inactive");
    }

    if (!this.model.get("can_downvote")) {
      this.$('.down').removeClass("inactive");
    }

    return this;
  },

  vote: function (event) {
    console.log(event.currentTarget)
    event.preventDefault();

    var that = this;

    if ($(event.target).hasClass("up")) {
      var val = 1
    } else {
      var val = -1
    }

    $.ajax({
      type: "POST",
      url: "/api/votes",
      data: {
        vote: {
          val: val,
          votable_id: this.model.id,
          votable_type: this.votableType
        }
      },
      success: function(data){
        that.model.fetch()
      }
    });
  }
})