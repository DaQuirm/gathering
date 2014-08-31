module.exports = (article) ->
	nxt.Element 'div',
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
