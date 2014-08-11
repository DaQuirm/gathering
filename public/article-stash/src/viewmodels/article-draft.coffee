class ArticleDraft
	constructor: ->
		@data = new nx.Cell value:{}

		@link = new nx.Cell
		@data.bind @link, '<->', new nx.Mapping 'link':'_'

		@title = new nx.Cell
		@data.bind @title, '<->', new nx.Mapping 'title':'_'

		@description = new nx.Cell
		@data.bind @description, '<->', new nx.Mapping 'description':'_'

		@tags = new nx.Collection
		@data.bind @tags, '<->', new nx.Mapping 'tags':'_'
		do @reset

	reset: ->
		@title.value = ''
		@link.value = ''
		@description.value = ''
		@tags.items = []

ArticleStash.viewmodels.ArticleDraft = ArticleDraft
