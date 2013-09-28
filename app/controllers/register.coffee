exports.render = (req, res) ->
  res.render 'register', req.user
