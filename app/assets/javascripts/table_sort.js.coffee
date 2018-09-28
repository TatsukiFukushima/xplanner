$ ->
  $('.table-sortable').sortable(
    axis: 'y'
    items: '.item'
    
    sort: (e, ui) ->
        ui.item.addClass('active-item-shadow')
    stop: (e, ui) ->
      ui.item.removeClass('active-item-shadow')
      # highlight the row on drop to indicate an update
      ui.item.children('td, div').effect('highlight', {}, 1000)
    
    update: (e, ui) ->
      item = ui.item
      item_data = item.data()
      params = { _method: 'put' }
      params[item_data.modelName] = { row_order_position: item.index() }
      $.ajax(
        type: 'POST'
        url: item_data.updateUrl
        dataType: 'json'
        data: params
      )
    )
    
 
    # stop: (e, ui) ->
    #   ui.item.children('td').effect('highlight')
