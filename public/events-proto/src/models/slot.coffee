Break = EventsProto.models.Break
Talk = EventsProto.models.Talk

class Slot

	@types = new nx.Collection items:['talk', 'break']

	constructor: ->
		@type = new nx.Cell value:Slot.types.items[0]
		@content = new Talk

	set_type: (type) ->
		switch type
			when 'talk'
				@content = new Talk
			when 'break'
				@content = new Break

EventsProto.models.Slot = Slot
