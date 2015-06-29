###
broadcast 1.0
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
      @broadcasts["#{id}"] = execute
      console?.log "Broadcast with ID \"#{id}\" has been set up to execute functions [%s] when called.", execute.join(", ")
    else
      console?.error "Please pass all parameters (id, execute) to Broadcast::create."
  shout: (id, _callback) ->
    if id
      for item, i in @broadcasts["#{id}"]
        eval item
      if _callback then _callback()
    else
      console?.error "Please pass the \"id\" parameter to Broadcast::shout."
  modify: (id, execute, newid) ->
    if id
      if execute
        oldexecute = @broadcasts["#{id}"]
        @broadcasts["#{id}"] = execute
        console?.log "Broadcast with ID \"#{id}\" has been modified to execute functions [%s] instead of functions [%s] when called.", execute.join(", "), oldexecute.join(", ")
      if newid
        @broadcasts["#{newid}"] = @broadcasts["#{id}"]
        delete @broadcasts["#{id}"]
        console?.log "Broadcast with ID \"#{id}\" has been renamed to \"#{newid}\"."
    else
      console?.error "Please pass the \"id\" parameter to Broadcast::modify."