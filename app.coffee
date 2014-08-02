var express = require('express'),
path = require('path'),
shortid = require('shortid'),
mongoq = require('mongoq'),
db = mongoq("arranjdb", {safe:false}),
app = express(),
http = require('http');

app.configure(function () {
  app.use(express.bodyParser());
  app.use(express.static(path.join(__dirname, 'public')));
  app.set('port', process.env.PORT || 3000);
  app.use(express.logger('dev'));  /* 'default', 'short', 'tiny', 'dev' */
  
  app.param(function(name, fn) { /* Replace this with the middleware at some point */
    if(fn instanceof RegExp) {
      return function(req, res, next, val) {
        var captures;
        if(captures = fn.exec(String(val))) {
          req.params[name] = captures;
          next();
        }
        else {
          next('route');
        }
      };
    }
  });
  app.param('id', /^\d+$/);
});

app.get('/ajax/items', function(req, res) {
  db.collection('items').find().toArray().done(function(items) {
    res.json(items);
  });
});

app.get('/ajax/items/:itemid', function(req, res) {
  db.collection('items').findOne({_id: req.params.itemid}).done(function(item) {
    res.json(item);
  });
});

app.post('/ajax/items', function(req, res) {
  var item = req.body;
  item._id = shortid.generate();
  db.collection('items').insert(item, {safe: true}).done(function(item) {
    res.json(item, 201);
  });
});

app.get('/ajax/list/:listid', function(req, res) {
  db.collection('items').find({"listid": +req.params.listid}).toArray().done(function(items) {
    res.json(items);
  });
});

//All incoming requests to this port will be directed to the `app`. `app` is a function that when executed 
//calls the first middleware in use and works it's way down the stack. 
http.createServer(app).listen(app.get('port'), function () {
  console.log("Express server listening on port " + app.get('port'));
});