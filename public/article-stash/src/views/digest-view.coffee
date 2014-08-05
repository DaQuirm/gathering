ArticleStash.views.Digest = (context) ->

	nxt.Element 'div',
			nxt.Class 'block-right'
			nxt.Element 'div',
				nxt.Class 'form'
				nxt.Element 'label',
					nxt.Text 'Date of delivery'
					nxt.Element 'input'
				nxt.Element 'button',
					nxt.Text 'Schedule'
