assign = require 'object-assign'

module.exports = (hexo) ->
  hexo.config.html_minifier = assign {
    exclude: []
  }, hexo.config.html_minifier

  priority = hexo.config.html_minifier.priority or 10000

  hexo.extend.filter.register 'after_generate', require('./lib/filter'), priority