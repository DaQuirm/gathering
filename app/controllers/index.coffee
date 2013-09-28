exports.render = (req, res) ->
  res.render 'index', req.user
