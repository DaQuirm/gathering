EventViewModel = EventsProto.viewmodels.EventViewModel

class EventCollection extends nx.RestCollection
	constructor: ->
		super
			url: '/events'
			item: EventViewModel

		@expanded_item = null

	expand: (item) ->
		@expanded_item?.expanded.value = no
		@expanded_item = item

	# create: ->
	# 	super @new_item, (item) =>
	# 		first = @todos.items[0]
	# 		@todos.insertBefore first, item

EventsProto.models.EventCollection = EventCollection
