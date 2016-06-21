# hexo-filter-htmlminifier

A Hexo filter to minify HTML files using [HTML Minifier](https://kangax.github.io/html-minifier/)

## Install

``` bash
npm install hexo-filter-htmlminifier --save
```

## Options

``` yaml
html_minifier:
  priority: 10000
  collapseWhitespace: true
  conservativeCollapse: false
  removeAttributeQuotes: true
  removeComments: true
  removeRedundantAttributes: true
  removeScriptTypeAttributes: true
  removeStyleLinkTypeAttributes: true
```

* **priority (optional):** set the priority of the minify filter to make sure the task excute after other HTML filters. If you are using GZip filter (or some others) at the same time, you may need to change this value.
* for other optional, please see [here](https://github.com/kangax/html-minifier#options-quick-reference).

