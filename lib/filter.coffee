minify = require('html-minifier').minify
minimatch = require 'minimatch'
async = require 'async'
assign = require 'object-assign'
accum = require 'accum'

TransformStream = require('stream').TransformStream

class Minifier extends TransformStream
  constructor: (opts) ->
    super()
    defaults =
      collapseWhitespace: true
      conservativeCollapse: false
      removeAttributeQuotes: true
      removeComments: true
      removeRedundantAttributes: true
      removeScriptTypeAttributes: true
      removeStyleLinkTypeAttributes: true
    this.opts = assign {}, opts, defaults
  
  _transform: (chunk, encoding, cb) ->
    this.push minify(chunk.toString('utf8'), this.opts)
    cb()
    

setRoutes = (opts, resolve, reject, route, paths) ->
  async.forEach(
    path,
    (path, callback) ->
      route.get path
        .pipe new Minifier(opts)
        .pipe accum.buffer (buffer) ->
          route.set path, buffer
          callback()
    , (err) ->
      resolve()
  )
      

module.exports = ->
  hexo = this
  route = hexo.route
  opts = hexo.config.html_minifier
  routes = route.list().filter (path) ->
    return minimatch path, '**/*.html', { nocase: true }
  
  return new Promise(
    (resolve, reject) ->
      setRoutes opts, resolve, reject, route, routes
  )