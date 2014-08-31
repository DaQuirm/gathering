module.exports = (article) ->

	nxt.Element 'div',
		nxt.Class 'form'
		nxt.Element 'label',
			nxt.Input
				cell: article.link
				content: [nxt.Attr 'placeholder', 'link']
		nxt.Element 'label',
			nxt.Input
				cell: article.title
				content: [nxt.Attr 'placeholder', 'title']
		nxt.Element 'label',
			nxt.Input
				cell: article.description
				content: [nxt.Attr 'placeholder', 'description']
		nxt.Element 'label',
			nxt.Input
				cell: article.tags
				content: [nxt.Attr 'placeholder', 'tags']
				converter: (tags) ->
					tags.join ', ' if tags
				back_converter: (string) ->
					string.split(/,\s*/)
		nxt.Element 'Button',
			nxt.Text 'Save'
			nxt.Event 'click', ->
				article.view.value = 'item'
				do article.save
