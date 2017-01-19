Template.post.onCreated ->
  @post = @data

Template.post.helpers
  "postTitle": ->
    return @name

  "postSubject": ->
    return @subject

  "postDescription": ->
    return @body

  "postTags": ->
    return @tags
