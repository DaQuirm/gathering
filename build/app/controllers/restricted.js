exports.test = function(req, res) {
  if (req.isAuthenticated()) {
    return res.send({
      hello: 'access granted'
    });
  } else {
    return res.send(403, 'Sorry! you cant see that.');
  }
};
