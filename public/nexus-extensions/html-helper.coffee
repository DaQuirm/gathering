nxt.Html = (markup) ->
	container = document.createElement 'div'
	container.innerHTML = markup
	type: 'Node'
	node: container.firstChild
	name: container.firstChild.nodeName


