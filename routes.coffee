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

Router.route '/',
 name: "home"
 template: "recentPosts"

 waitOn: -> [
   Meteor.subscribe 'posts'
 ]

 data: ->
   Posts.find({}).fetch()

Router.route '/new-post',
  name: 'newPost'
  template: 'newPost'

  onAfterAction: ->

  waitOn: -> [
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

Router.route '/admin/user-panel',
  name: 'adminPanel'
  template: 'adminPanel'

  onBeforeAction: ->
    role = Roles.getRolesForUser Meteor.userId()
    role = role.toString()
    if role != "admin"
      this.redirect 'pageNotFound'
    else this.next()

  waitOn: -> [
    Meteor.subscribe 'users'
  ]

  data: ->
    Meteor.users.find({}).fetch()

Router.route 'oops',
  name: "pageNotFound"
  template: "pageNotFound"
