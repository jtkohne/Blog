# import { BlogSettings } from '../../../../lib/appSettings';

Template.adminPanel.onCreated ->

  @users = new ReactiveVar(@data or null);

Template.adminPanel.onRendered ->

  # console.log(@users.get())


Template.adminPanel.helpers
  users: ->
    return @

  userId: ->
    # console.log(@)
    @emails[0].address


  currentRole: ->
    # console.log(@)
    # roleOption = if @role then @role
    # currentRole = if @roles then @roles[0]
    #
    # console.log(roleOption)
    # if roleOption and currentRole
    #   return "Found both variables"

    # if @roles
    #   currentRole = @roles[0]
    #   console.log(currentRole)

  userTypes: -> # generate user types
    roles = [ {role: "admin"}, {role: "editor"}, {role: "standard"} ]

  role: ->
    return @role

  userhasNoRole: ->
    if not @roles
      return selected="selected"

  userIsAdmin: ->
    if @roles
      if @roles[0] is "admin"
        return selected="selected"
    return ''

  userIsEditor: ->
    if @roles
      if @roles[0] is "editor"
        return selected="selected"
    return ''

  userIsStandard: ->
    if @roles
      if @roles[0] is "standard"
        return selected="selected"
    return ''

  userPosts: ->
    return Posts.find({}).fetch()

  # changedRole: ->
  #   console.log(@)
  #   dbRole = Roles.getRolesForUser @_id
  #   # selected = $(e.target).parent().siblings('.c-admin-table__data').find('.c-admin__option:selected')["0"]
  #   role = $(selected).val().toLowerCase()

    # if role != dbRole
    #   return 'show'
    # return ''

  # #
  # # "HelloWorld": ->
  # #   return alert("hello world")
  #
  # "siteUsers": ->
  #   return [{id: '123'},{id: '234'}]
    # cosole.log(users)
  #
  # "userEmail": ->
  #   console.log(@)
    # address = _.find(@email, (obj) -> return obj.address)
    # console.log(address)
    # return address

Template.adminPanel.events
  'click [data-action="save"]': (e, template) ->
    userId = @_id
    selected = $(e.target).parent().siblings('.c-admin-table__data').find('.c-admin__option:selected')["0"]
    role = $(selected).val().toLowerCase()

    if not role
      return alert("please selected a role to update user permissions")

    Meteor.call 'User.changeUserRole', userId, role, (error, response) ->
      if error?
        alert(error.reason)
        return console.error("ERROR: "+error.reason);
      else
        alert(response)
        console.log(response)

  'change [data-action=change-user-role]': (e, template) ->
    userId = @_id
    role = Roles.getRolesForUser @_id
    role = role.toString()
    selected = $(e.target).val().toLowerCase()
    button = $(e.target).parent().siblings().find('[data-action=save]')
    if role != selected
      button.addClass('show')
    else
       button.removeClass('show')

  'change [data-action=change-number-of-page-items]': (e, template) ->
    # appSetting = Meteor.settings.public.postsPerPage
    picked = $(e.target).val()
    # console.log(appSetting)
    console.log(picked)
    # if appSetting != picked
    #   Meteor.call('Settings.updateNumberOfItemsPerPage', picked)
    Meteor.call 'Settings.updateNumberOfItemsPerPage', parseInt(picked), (error, response) ->
      if error?
        alert(error.reason)
        return console.error('ERROR: '+error.reason)
      else
        alert("Successfully updated number of posts to :"+response)
        return console.log("Successfully updated number of posts to: "+response)
