Interview.Views.BookmarkTags ||= {}

class Interview.Views.BookmarkTags.NewView extends Backbone.View
  template: JST["backbone/templates/bookmark_tags/new"]

  events:
    "submit #new-bookmark_tag": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (bookmark_tag) =>
        @model = bookmark_tag
        window.location.hash = "/#{@model.id}"

      error: (bookmark_tag, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
