Newsletter.views.Articles = (context) ->

	nxt.Element 'div',
		nxt.Class 'articles', true
		nxt.Element 'div',
			nxt.Element 'div',
				nxt.Element 'input',
					nxt.Attr 'placeholder', 'link'
					nxt.Event 'input', (ev) ->
						context.new_article.link.value = @value
			nxt.Element 'div',
				nxt.Element 'input',
					nxt.Attr 'placeholder', 'title'
					nxt.Event 'input', (ev) ->
						context.new_article.title.value = @value
			nxt.Element 'div',
				nxt.Element 'textarea',
					nxt.Attr 'placeholder', 'description'
					nxt.Event 'input', (ev) ->
						context.new_article.description.value = @value
			nxt.Element 'div',
				nxt.Element 'Button',
					nxt.Text 'Create'
					nxt.Event 'click', (ev) ->
						context.save context.new_article
			nxt.Element 'div',
				nxt.Element 'Input',
					nxt.Attr 'placeholder', 'tags (use \',\' for multiple)'
					nxt.Event 'blur', (ev) ->
						context.new_article.tags = new nx.Collection
						for tag in @value.replace(/\s*,\s*/g,',').split ','
							context.new_article.tags.append tag

		nxt.Element 'div',
			nxt.Collection context.articles.items, (article) ->
				nxt.Element 'div',
					nxt.Element 'a',
						nxt.Attr 'href', article.link.value
						nxt.Text article.title.value
					nxt.Element 'p',
						nxt.Text article.description.value
					nxt.Element 'p',
						nxt.Collection article.tags, (tag) ->
							nxt.Element 'span',
								nxt.Text tag



