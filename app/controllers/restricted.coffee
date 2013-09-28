exports.test = (req, res) ->
  if req.isAuthenticated()
    res.send hello:'access granted'
  else
    res.send 403, 'Sorry! you cant see that.'
