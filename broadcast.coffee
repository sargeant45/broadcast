###
broadcast 1.1
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
      @broadcasts[id] = -> execute()
      
      console?.log "Broadcast with ID \"#{id}\" has been set up to execute functions:\n\t%s\nwhen called.", execute.toString().replace(/\n/g, "\n\t")
    else
      console?.error "Please pass all parameters (id, execute) to Broadcast::create."
  shout: (id, sync, _callback) ->
    if id
      if sync
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
            setTimeout(
              (broadcasts) ->
                broadcasts[id]()
                if _callback then _callback()
              , 0, @broadcasts)
          
          when "sync"
            @broadcasts[id]()
            if _callback then _callback()
          else
            if _callback then _callback()
      else
        if _callback then _callback()
    else
      console?.error "Please pass the \"id\" parameter to Broadcast::shout."
  modify: (id, execute, newid) ->
    if id
      if execute
        oldexecute = (broadcasts) -> broadcasts[id]
        @broadcasts[id] = -> execute
        console?.log "Broadcast with ID \"#{id}\" has been modified to execute code:\n\t%s\ninstead of functions:\n[%s]\nwhen called.", execute.toString().replace(/\n/g, "\n\t"), oldexecute(@broadcasts).toString().replace(/\n/g, "\n\t")
      
      if newid
        @broadcasts["#{newid}"] = @broadcasts[id]
        delete @broadcasts[id]
        console?.log "Broadcast with ID \"#{id}\" has been renamed to \"#{newid}\"."
    else
      console?.error "Please pass the \"id\" parameter to Broadcast::modify."
  add: (id, execute) ->
    if id && execute
      oldexecute = @broadcasts[id]
      @broadcasts[id] = ->
        oldexecute();
        execute();
      
      console?.log "Broadcast with ID \"#{id}\" has been set up to execute newly added code:\n\t%s\nwhen called.", execute.toString().replace(/\n/g, "\n\t")
    else
      console?.error "Please pass all parameters (id, execute) to Broadcast::add."