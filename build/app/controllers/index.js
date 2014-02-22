exports.render = function(req, res) {
  return res.render('index', req.user);
};
