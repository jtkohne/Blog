Meteor.startup () ->

if Meteor.isClient
  Router.configure
    layoutTemplate: 'master'
    # loadingTemplate: 'loading'
    # notFoundTemplate: 'notFound'
    # yieldTemplates:
    #   header:
    #     to: 'header'
    #   footer:
    #     to: 'footer'
  #   trackPageView: true
  # Router.plugin('dataNotFound')

  # Router.onAfterAction ->

Router.route '/new-post',
  name: 'newPost'
  template: 'newPost'

  onAfterAction: ->

  waitOn: -> [
    Meteor.subscribe 'users'
    Meteor.subscribe 'posts'
  ]

Router.route '/recents',
  name: 'recentPosts'
  template: 'recentPosts'

  onAfterAction: ->

  waitOn: -> [
    Meteor.subscribe 'posts'
  ]

  data: ->
    Posts.find({}).fetch()

Router.route 'post/:id',
  name: 'posting'
  template: 'post'
  # loadingTemplate: 'loading'

  waitOn: -> [
    Meteor.subscribe 'posts'
  ]

  data: ->
    Posts.first({_id: @params.id})


# ADMIN ROUTES

Router.route '/admin/panel',
  name: 'adminPanel'
  template: 'adminPanel'

  waitOn: -> [
    Meteor.subscribe 'users'
  ]

  data: ->
    Meteor.users.find({}).fetch()
