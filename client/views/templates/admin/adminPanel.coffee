Template.adminPanel.onCreated ->

  @users = new ReactiveVar(@data or null)
  # console.log(@users)

Template.adminPanel.helpers ->

  user: ->
    return Template.instance().users.get()

  userEmail: ->
    console.log(@)
    # address = _.find(@email, (obj) -> return obj.address)
    # console.log(address)
    # return address

Template.adminPanel.events
