xmessages_height = ->
  temp = 0;
  $("div.xmessage").each ->
    temp += ($(this).height());
  return temp
  
  
x_id = ->
  $('#xmessages').data('xroom_id')
  
xroom_ch = ->
  id = x_id()
  if id?
    return { channel: "XroomChannel", xroom_id: id }
  else 
    return null

document.addEventListener 'turbolinks:request-start', ->
  if xroom_ch()?
    App.xroom.disconnected()


document.addEventListener 'turbolinks:load', ->
  App.xroom = App.cable.subscriptions.create { channel: "XroomChannel", xroom_id: $('#xmessages').data('xroom_id') },
    connected: ->
      # Called when the subscription is ready for use on the server
  
    disconnected: ->
       App.cable.subscriptions.remove(this)
       this.perform('unsubscribed') 
      # Called when the subscription has been terminated by the server
  
    received: (data) ->
      if data['xmessage']?
        $('#xmessages').append data['xmessage']
        $('section.xmessage_box').scrollTop(xmessages_height());
      if data['xuser_count']?
        $('#xuser_count').html data['xuser_count']
        $('.xroom_users').html data['xusers']
  
    speak: (xmessage) ->
      @perform 'speak', xmessage: xmessage
  
  
$(document).on 'keypress', '[data-behavior~=xroom_speaker]', (event) ->
  if event.keyCode is 13 && !event.shiftKey # return = send 
    App.xroom.speak event.target.value
    event.target.value = ''
    event.preventDefault()


