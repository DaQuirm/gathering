
class Article extends nx.RestDocument
	constructor: (options) ->
		super
			url: '/articles/{_id}'

		@data.value = options?.data or {}

		@link = new nx.Cell
		@data.bind @link, '<->', new nx.Mapping 'link':'_'

		@title = new nx.Cell
		@data.bind @title, '<->', new nx.Mapping 'title':'_'

		@description = new nx.Cell
		@data.bind @description, '<->', new nx.Mapping 'description':'_'

		@tags = new nx.Collection
		@tags.bind @data, '<->', new nx.Mapping '_':'tags'

Newsletter.models.Article = Article
