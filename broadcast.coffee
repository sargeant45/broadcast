###
broadcast 1.2
JavaScript function passing done the Scratch way
open-source under the MIT license, (c) Ethan Arterberry, 2015

<broadcast.coffee>
written in CoffeeScript, JavaScript done right
###

class Broadcast
  constructor: ->
    @broadcasts = {}
    console?.log "New Broadcast class created."
  create: (id, execute) ->
    if id && execute
      @broadcasts[id] = []
      @broadcasts[id].push(item) for item in execute
      
      console?.log "Broadcast with ID \"#{id}\" has been set up to execute functions:\n\t%s\nwhen called.", execute.toString().replace(/\n/g, "\n\t")
    else
      console?.error "Please pass all parameters (id, execute) to Broadcast::create."
  shout: (id, sync, _callback) ->
    if  !id
      throw "You did not specify a Broadcast ID."
    if !sync
      throw "You did not specify a sync type."
    switch sync
      when "async"
        ###@cc_on
          // conditional IE < 9 only fix for setTimeout params
          @if (@_jscript_version <= 9)
          (function(f){
             window.setTimeout =f(window.setTimeout);
             window.setInterval =f(window.setInterval);
          })(function(f){return function(c,t){var a=[].slice.call(arguments,2);return f(function(){c.apply(this,a)},t)}});
          @end
        @
        ###
        setTimeout(->
          if _callback then _callback()
        , 0, item)
        for item in @broadcasts[id]
          setTimeout((item) ->
            item()
          , 0, item)
        
      when "sync"
        for item in @broadcasts[id]
          item()
        if _callback then _callback()
      else
        throw "'sync' can only be 'async' or 'sync'."
  modify: (id, execute, newid) ->
    if id
      if execute
        oldexecute = (broadcasts) -> broadcasts[id]
        @broadcasts[id] = execute
        console?.log "Broadcast with ID \"#{id}\" has been modified to execute code:\n\t%s\ninstead of functions:\n[%s]\nwhen called.", execute.toString().replace(/\n/g, "\n\t"), oldexecute(@broadcasts).toString().replace(/\n/g, "\n\t")
      
      if newid
        @broadcasts[newid] = @broadcasts[id]
        delete @broadcasts[id]
        console?.log "Broadcast with ID \"#{id}\" has been renamed to \"#{newid}\"."
    else
      console?.error "Please pass the \"id\" parameter to Broadcast::modify."
  add: (id, execute) ->
    if id && execute
      @broadcasts[id].push(item) for item in execute
      
      console?.log "Broadcast with ID \"#{id}\" has been set up to execute newly added code:\n\t%s\nwhen called.", execute.toString().replace(/\n/g, "\n\t")
    else
      console?.error "Please pass all parameters (id, execute) to Broadcast::add."