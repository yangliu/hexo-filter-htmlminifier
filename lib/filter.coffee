minify = require('html-minifier').minify
minimatch = require 'minimatch'
async = require 'async'
assign = require 'object-assign'
accum = require 'accum'
TransformStream = require('stream').Transform

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
    try
      chunk = minify(chunk.toString('utf8'), this.opts)
    catch err
      throw err

    this.push chunk
    cb()
    

setRoutes = (ctx, opts, resolve, reject, route, paths) ->
  async.forEach(
    paths,
    (path, callback) ->
      route.get path
        .pipe new Minifier(opts)
          .on 'error', (e) ->
            ctx.log.debug "Minifier Error: %s", e
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
      setRoutes hexo, opts, resolve, reject, route, routes
  )