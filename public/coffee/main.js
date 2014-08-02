(function() {
  require.config({
    paths: {
      "jquery": "../components/jquery/dist/jquery",
      "underscore": "../components/underscore/underscore",
      "backbone": "../components/backbone/backbone"
    },
    shim: {
      'backbone': {
        deps: ['underscore', 'jquery'],
        exports: 'Backbone'
      },
      'underscore': {
        exports: '_'
      }
    }
  });

  require(["jquery", "underscore"], function($, _) {
    var toggle;
    toggle = false;
    return setInterval((function(_this) {
      return function() {
        if (toggle) {
          $('#flasher').text('GGIIFFGGYY');
        } else {
          $('#flasher').text('GIFGY');
        }
        return toggle = !toggle;
      };
    })(this), 200);
  });

}).call(this);
