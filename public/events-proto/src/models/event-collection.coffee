EventViewModel = EventsProto.viewmodels.EventViewModel

class EventCollection extends nx.RestCollection
	constructor: ->
		super
			url: '/events'
			item: EventViewModel

		@expanded_item = null
		@new_item = new nx.Cell value:null

	expand: (item) ->
		@expanded_item?.expanded.value = no
		@expanded_item = item

	show_create_form: ->
		# @new_item.value = new Event

	# create: ->
	# 	super @new_item, (item) =>
	# 		first = @todos.items[0]
	# 		@todos.insertBefore first, item

EventsProto.models.EventCollection = EventCollection
