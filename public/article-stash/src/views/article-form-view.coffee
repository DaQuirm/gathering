module.exports = (context, form) ->

	nxt.Element 'div',
		nxt.Class 'form', true
		nxt.Binding context.form_collapsed, (collapsed) ->
			nxt.Class 'collapsed', collapsed
		nxt.Element 'label',
			nxt.Input
				cell: context.article_form.value.link
				content: [nxt.Attr 'placeholder', 'link']
		nxt.Element 'label',
			nxt.Input
				cell: context.article_form.value.title
				content: [nxt.Attr 'placeholder', 'title']
		nxt.Element 'label',
			nxt.Input
				cell: context.article_form.value.description
				content: [nxt.Attr 'placeholder', 'description']
		nxt.Element 'label',
			nxt.Input
				cell: context.article_form.value.tags
				content: [nxt.Attr 'placeholder', 'tags']
				converter: (tags) ->
					tags.join ', ' if tags
				back_converter: (string) ->
					string.split(/,\s*/)
		nxt.Element 'Button',
			nxt.Binding context.form_collapsed, (collapsed) ->
				nxt.Text if collapsed then 'Create' else 'Save'
			nxt.Binding context.form_collapsed, (collapsed) ->
				nxt.Event 'click',
					if collapsed
						-> context.form_collapsed.value = no
					else
						-> do context.save
