assign = require 'object-assign'

hexo.config.html_minifier = assign {
  exclude: []
}, hexo.config.html_minifier

priority = html_minifier.priority or 10000

hexo.extend.filter.register 'after_generate', require('./lib/filter'), priority