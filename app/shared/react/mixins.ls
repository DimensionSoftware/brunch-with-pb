export FormHelpers =
  update: (ev, id) -> # update state
    if id?index-of(\.) > -1 # id is a path, so go one level deep
      [key, elm] = id.split \.
      new-state = {"#key":{}} <<< @state    # default
      new-state[key][elm] = ev.target.value # update
      @set-state new-state
    else
      @set-state "#id": ev.target.value

  update-fn: (id) ->
    (ev) ~>
      @update ev, id

  on-enter: (cb) ->
    (ev) ~>
      if ev.native-event.key-code is 13
        cb ev

  report-error: (jqxhr, status, error) ->
    add = $.gritter.add

    try # parse json
      res = JSON.parse jqxhr.response-text
    catch
      add title: e.message, text: e.stack

    if status is \error # consolidate
      add title: 'Try Again!', text: if res?errors?length then res.errors.join \<br> else 'Double-check all form inputs'
      console.warn res?errors
    else
      res?errors |> each -> add title: \Error, text: it


export DataTables =
  # both datatable and react want to own the data.  let datatable win this time
  reload-table: (table, data, row-fn) ->
    if data.length
      table._fn-clear-table!
      for d in data # add all rows
        if id = d.id?to-string!
          table.fn-add-data(row-fn d)
      for r in table.find \tr # go back and id rows when possible
        tr = $ r
        if val = (tr.find \td:first)?html!
          tr
            ..data \id, val
            ..attr \data-id, val

  toggle-single-active-row: (ev, id) ->
    selection = $ @get-DOM-node! .find \.active
    row       = $ ev.target .parents \tr

    unless selection?0 is row?0 # disallow multi-select
      selection.remove-class \active
    row.toggle-class \active

    # activate selection or none
    @props.on-activate if ($ @get-DOM-node! .find \.active).length then id else void

  toggle-multi-active-row: (ev, id) ->
    row = $ ev.target .parents \tr
    unless row.has-class # activate if selected
      @props.on-activate id
    row.toggle-class \active
    @props.on-activate if ($ @get-DOM-node! .find \.active).length then id else void


export InitialStateAsync =
  get-initial-state-async: (cb) ->
    path = "#{window.location.pathname}#{if window.location.search then "?#{window.location.search}" else ''}"
    $.ajax(
      data-type: \json
      accepts:
        json: \application/json
      url: path
      success: (locals) ->
        #console.log \get-initial-state-async, locals
        $ 'head title' .html "#{locals.title} | ICEmail"
        cb null, locals
      error: (jqxhr, status, error) ->
        $.gritter.add title: status, text: "Could not load '#path'"
        cb error
    )

  soft-reload: ->
    err, state <~ @get-initial-state-async
    if err then $.gritter.add title: "Error", text: err
    console.log \state, state
    @set-state state
