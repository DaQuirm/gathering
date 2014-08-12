module.exports = (context) ->

	nxt.Element 'div',
		nxt.Class 'block-left', true
		nxt.Element 'div',
			nxt.Class 'form', true
				nxt.Input
					cell: context.new_article.link
					content: [nxt.Attr 'placeholder', 'link']
				nxt.Input
					cell: context.new_article.title
					content: [nxt.Attr 'placeholder', 'title']
				nxt.Input
					cell: context.new_article.description
					content: [nxt.Attr 'placeholder', 'description']
				nxt.Input
					cell: context.new_article.tags
					content: [nxt.Attr 'placeholder', 'tags']
					converter: (tags) ->
						tags.join ', ' if tags
					back_converter: (string) ->
						string.split(/,\s*/)
				nxt.Element 'Button',
					nxt.Text 'Save'
					nxt.Event 'click', (ev) ->
						context.save context.new_article.data.value

		nxt.Element 'ul',
			nxt.Class 'articles-list', true
			nxt.Collection context.articles.items, (article) ->
				nxt.Element 'li',
					nxt.Element 'a',
						nxt.Class 'title', true
						nxt.Attr 'href', article.link.value
						nxt.Text article.title.value
					nxt.Element 'p',
						nxt.Class 'description', true
						nxt.Text article.description.value
					nxt.Element 'ul',
						nxt.Collection article.tags, (tag) ->
							nxt.Element 'li',
								nxt.Text tag
						nxt.Class 'tags'
					nxt.Element 'ul',
						nxt.Class 'action-menu'
						nxt.Element 'li',
								nxt.Class 'approve'
						nxt.Element 'li',
								nxt.Class 'edit'
						nxt.Element 'li',
								nxt.Class 'remove'
								nxt.Event 'click', (ev) ->
									article.remove ->
										context.articles.items.remove article
