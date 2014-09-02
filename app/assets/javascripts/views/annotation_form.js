Prosody.Views.AnnotationForm = Backbone.View.extend({
  template: JST["annotations/form"],

  events: {
    'submit .new-annotation': 'submit',
    'change .image-input': 'fileSelect'
  },

  render: function () {
    var renderedContent = this.template({
      annotation: this.model
    });
    this.$el.html(renderedContent);

    return this;
  },

  submit: function (event) {
    var that = this;

    event.preventDefault();

    var attrs = $(event.target).serializeJSON();

    if (that.imageURL) {
      attrs['image'] = that.imageURL
    }

    this.collection.create(attrs, {
      wait: true
    });
  },

  fileSelect: function (event) {
    var that = this
    var imageFile = event.currentTarget.files[0];
    var reader = new FileReader();

    reader.onloadend = function () {
      that.imageURL = this.result
      that._updatePreview(this.result);
    }

    if (imageFile) {
      reader.readAsDataURL(imageFile);
    } else {
      this._updatePreview("");
    }
  },

  _updatePreview: function (imageData) {
    this.$el.find('.image-preview').attr('src', imageData)
  }
})