Newsletter.views.Articles = (context) ->

	nxt.Element 'div',
		nxt.Class 'block-left', true
		nxt.Element 'div',
			nxt.Class 'form', true
				nxt.Element 'input',
					nxt.Attr 'placeholder', 'link'
					nxt.Event 'input', (ev) ->
						context.new_article.link.value = @value
				nxt.Element 'input',
					nxt.Attr 'placeholder', 'title'
					nxt.Event 'input', (ev) ->
						context.new_article.title.value = @value
				nxt.Element 'textarea',
					nxt.Attr 'placeholder', 'description'
					nxt.Event 'input', (ev) ->
						context.new_article.description.value = @value
				nxt.Element 'Input',
					nxt.Attr 'placeholder', 'tags (use \',\' for multiple)'
					nxt.Event 'blur', (ev) ->
						context.new_article.tags = new nx.Collection
						for tag in @value.replace(/\s*,\s*/g,',').split ','
							context.new_article.tags.append tag
				nxt.Element 'Button',
					nxt.Text 'Create'
					nxt.Event 'click', (ev) ->
						context.save context.new_article

		nxt.Element 'ul',
			nxt.Class 'news-list', true
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
						nxt.Class 'tags',
						nxt.Collection article.tags, (tag) ->
							nxt.Element 'li',
								nxt.Text tag



