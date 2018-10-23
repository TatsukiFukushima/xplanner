App.chat = null

current_user_id = ->
  $('input:hidden[name="from_id"]').val()

user_id = ->
  $('input:hidden[name="to_id"]').val()
  
room_id = ->
  $('input:hidden[name="to_id"]').val()

room_ch = ->
  id = room_id()
  return {channel: 'NotificationChannel', room_id: id}

document.addEventListener 'turbolinks:request-start', ->
  if room_ch()?
    App.notification.unsubscribe()

document.addEventListener 'turbolinks:load', ->
  if room_ch()?
    App.notification = App.cable.subscriptions.create room_ch(),
      received: (data) ->
        $('#notices').append data['notice']

      speak: (from_id, to_id, content) ->
        @perform 'speak', {
          "from_id": from_id
          "to_id": to_id
          "content": content
        }

$(document).on 'keypress', '[data-behavior~=notification_speaker]', (event) ->
  if event.which is 13
    value = event.target.value
    App.notification.speak(current_user_id(), user_id(), value)
    event.target.value = ''
    event.preventDefault()