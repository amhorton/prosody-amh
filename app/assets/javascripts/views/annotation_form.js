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

    attrs['article_id'] = this.collection.article.id;

    function success () {
      that.collection.fetch();
    }

    console.log("attrs:", attrs)

    this.model.set(attrs);

    console.log("this.model:", this.model)



    if (this.model.isNew()) {
      this.collection.create(this.model, {
        success: success,
        wait: true
      });
    } else {
      this.model.save({}, {
        success: success
      });
    }
  },

  fileSelect: function (event) {
    console.log(event.currentTarget)
    var that = this
    var imageFile = event.currentTarget.files[0];
    var reader = new FileReader();

    reader.onloadend = function () {
      that.model.set("image", this.result);
      console.log("that.model", that.model)
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

// submit: function(event){
//     var that = this;
//     var formData = $(event.currentTarget).serializeJSON();
//
//     event.preventDefault();
//
//     this.model.save(formData.post, {
//       success: function(){
//         that.collection.add(that.model);
//
//         // Remove the image attribute with raw data
//         // from the model after uploading it.
//         delete that.model.attributes.image;
//         console.log(that.model);
//
//         Backbone.history.navigate("", { trigger: true });
//       }
//     })
//   },
//
//   fileSelect: function(event){
//     var that = this;
//     var imageFile = event.currentTarget.files[0];
//     var reader = new FileReader();
//
//     reader.onloadend = function(){
//       that.model.set("image", this.result);
//       that._updatePreview(this.result);
//     }
//
//     if(imageFile){
//       reader.readAsDataURL(imageFile);
//     } else {
//       this._updatePreview("");
//     }
//   },
//
//   _updatePreview: function(imageData){
//     this.$el.find("#post-image-preview").attr("src", imageData);
//   }