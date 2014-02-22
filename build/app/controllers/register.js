exports.render = function(req, res) {
  return res.render('register', req.user);
};
