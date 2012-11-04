class Interview.Routers.BookmarkTagsRouter extends Backbone.Router
  initialize: (options) ->
    @bookmarkTags = new Interview.Collections.BookmarkTagsCollection()
    @bookmarkTags.reset options.bookmarkTags

  routes:
    "new"      : "newBookmarkTag"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newBookmarkTag: ->
    @view = new Interview.Views.BookmarkTags.NewView(collection: @bookmark_tags)
    $("#bookmark_tags").html(@view.render().el)

  index: ->
    @view = new Interview.Views.BookmarkTags.IndexView(bookmark_tags: @bookmark_tags)
    $("#bookmark_tags").html(@view.render().el)

  show: (id) ->
    bookmark_tag = @bookmark_tags.get(id)

    @view = new Interview.Views.BookmarkTags.ShowView(model: bookmark_tag)
    $("#bookmark_tags").html(@view.render().el)

  edit: (id) ->
    bookmark_tag = @bookmark_tags.get(id)

    @view = new Interview.Views.BookmarkTags.EditView(model: bookmark_tag)
    $("#bookmark_tags").html(@view.render().el)
