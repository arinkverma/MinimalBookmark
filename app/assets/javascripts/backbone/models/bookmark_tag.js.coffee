class Interview.Models.BookmarkTag extends Backbone.Model
  paramRoot: 'bookmark_tag'

  defaults:
    bookmark_id: null
    tag_id: null

class Interview.Collections.BookmarkTagsCollection extends Backbone.Collection
  model: Interview.Models.BookmarkTag
  url: '/bookmark_tags'
