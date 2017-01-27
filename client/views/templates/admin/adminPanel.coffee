# import { BlogSettings } from '../../../../lib/appSettings';
createSelectList = () ->
  return {
    label: "Featured Post",
    labelClass: "c-admin__label",
    selectClass: "c-admin__picklist"
  }
Template.adminPanel.onCreated ->
  @users = new ReactiveVar(@data.users or null);
  @posts = @data.posts;
  @settings = @data.settings;
  @featuredSetting = _.find @settings, (set) -> return set.name is "numberOfFeatured"
  @numberOfFeatured = new ReactiveVar(@featuredSetting.value or null);

  @autorun =>
    @tab = new ReactiveVar();

Template.adminPanel.onRendered ->
  @tabs = $('.c-tab')
  @featuredList = $('.c-admin__picklist')

Template.adminPanel.helpers
  users: ->
    return Template.instance().users.get()

  userId: ->
    # console.log(@)
    @emails[0].address

  tabs: ->
    return [
      {
        name: "User Settings",
        # link: "#userSettings",
        dataLabel: "userSettings",
        active: true
      },
      {
        name: "View Settings",
        # link: "#viewSettings",
        dataLabel: "viewSettings",
        active: false
      },
    ]

  tabIsActive: -> # sets the tab styling to active
    tab = Template.instance().tab.get()
    if @ is tab
      return 'active'
    else
      return ''

  showTab: ->
    tab = Template.instance().tab?.get()
    tabs = Template.instance().tabs
    _.each tabs, (panel) ->
      if panel.dataset.label is tab.dataLabel
        return $(panel).fadeIn("fast").addClass("active")
      return $(panel).hide().removeClass("active")

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
    return Template.instance().posts

  selectLists: ->
    number = Template.instance().numberOfFeatured.get()
    lists = []
    _(number).times (n) -> lists.push(createSelectList())
    return lists

  isSelectedFeatureNumber: ->
    setting = Template.instance().featuredSetting.value
    picked = Template.instance().numberOfFeatured.get()

    console.log(setting)
    console.log(picked)
    if setting is picked
      console.log "triggered"
      return 'show'
    return

Template.adminPanel.events
  'click .c-tabs__link': (e, template) ->
    e.preventDefault
    @active = true
    template.tab.set(@)

  'click [data-action="save"]': (e, template) ->
    userId = @_id
    selected = $(e.target).parent().siblings('.c-admin-table__data').find('.c-admin__option:selected')["0"]
    role = $(selected).val().toLowerCase()

    if not role
      return alert("please selected a role to update user permissions")

    Meteor.call 'User.changeUserRole', userId, role, (error, response) ->
      if error?
        Toast.error("There was an error updaing the user role: "+error.reason, "Role Update Failed:", {displayDuration: 3000})
      else
        Toast.success("Successfully chnaged user role to: "+response, "User Role Updated", {displayDuration: 3000})

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

  'change [data-action=select-number-of-featured-items]': (e, template) ->
    picked = $(e.target).val()
    template.numberOfFeatured.set(picked)
    # console.log(template.featuredSetting);
    # console.log(template.numberOfFeatured.get())
    # button = $('[data-action=change-number-of-featured-items]');
    # setting = template.featuredSetting
    # selected = template.numberOfFeatured.get()


  'change [data-action=change-number-of-page-items]': (e, template) ->
    picked = $(e.target).val()

    Meteor.call 'Settings.changeNumberOfItemsPerPage', parseInt(picked), (error, response) ->
      if error?
        Toast.error("There was an error updating number of items per page "+error.message, "Setting Failed: "+error.errorType, {displayDuration: 5000})
      else
        Toast.success("Successfully updated number of items per page: "+response, "Setting Added", {displayDuration: 3000})

  'click [data-action=change-number-of-featured-items]': (e, template) ->
    picked = $(e.target).siblings('.c-admin__picklist').val()
    template.numberOfFeatured.set(picked) # set reactive variable to refresh view

    Meteor.call 'Settings.changeNumberOfFeaturedItems', parseInt(picked), (error, response) ->
      if error?
        Toast.error("There was an error updating number of featured post setting: "+error.message, "Setting Failed: "+error.errorType, {displayDuration: 5000})
      else
        Toast.success("Successfully updated number of featured posts to: "+response, "Success", {displayDuration: 3000})
