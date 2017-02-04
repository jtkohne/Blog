Meteor.startup ->
	$(document).ready ->
    if navigator.cookieEnabled
      authenticated = Cookie.get 'sblog.authAttempt'
      if not authenticated
        expires = moment().add(1, 'hours').toDate()
        Cookie.set 'sblog.authAttempt', true, expires: expires
