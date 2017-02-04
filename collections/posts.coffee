class @Posts extends Minimongoid

  @_collection: new Meteor.Collection 'posts'

  @validatePost: (post) ->
    errors []

    unless post?
      throw new Meteor.Error(400, 'Invalid Posting')

    if not checkForName(post.name)
      errors.push('Your posting has no name...You must have a title to post.')

    if errors.length > 0
      throw new Meteor.Error(400, errors)

    return errors


  @checkForName: (name) ->
    if name?
      return name
    else
      return false

  if Meteor.isServer

    # Meteor.publish 'posts', ->
    #   # posts = Posts.find({})
    # posts = Posts.find({},
    #   { fields: {
    #       name: 1,
    #       subject: 1,
    #       body: 1,
    #       # photos: 1,
    #       createdAt: 1,
    #       tags: 1,
    #     }
    #   })
    # if posts?
    #   return posts
    # return @.ready()

    Meteor.users.allow
      insert: ->
        true
      update: ->
        false
      remove: ->
        false
    Meteor.users.deny
      insert: ->
        false
      update: ->
        true
      remove: ->
        true

    Meteor.methods

      'Posts.save': (post) ->
        check post, Object
        # check post,
        #   title: String
        #   subject: String
        #   body: String
        #   # images: Match.Maybe(String || [String])
        #   tags: Match.Maybe([ String ])
        #   createdAt: Date
        #   owner: Match.Maybe([String])
        #   # userRole: String
        #   type: Match.Maybe([String])

        if !@userId
          throw new (Meteor.Error)('Not Authorized')
        else
          return Posts.create(post)

      'removeAllPosts': (error, response) ->
        return Posts.remove({})
