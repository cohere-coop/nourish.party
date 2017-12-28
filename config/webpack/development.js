const environment = require('./environment')
const path = require('path')
const express = require('express')
const KssWebpackPlugin = require('kss-webpack-plugin')

function railsRootJoin (pathname) {
  return path.join(__dirname, '..', '..', pathname)
}

function styleguideRelativePath (pathname) {
  return path.join(environment.config.output.publicPath, pathname)
}

// Since KssWebpackPlugin needs filenames at configure-time,
// we can't include the hash in development filenames
environment.config.set('output.filename', '[name].js')
const extractTextPlugin = environment.plugins.get('ExtractText')
extractTextPlugin.filename = '[name].css'

environment.plugins.prepend('KSS', new KssWebpackPlugin({
  source: railsRootJoin('app/assets/src/stylesheets'),
  destination: railsRootJoin('design/styleguide'),
  css: styleguideRelativePath('application.css'),
  js: styleguideRelativePath('application.js')
}))

environment.config.set('devServer.before', (app) => {
  app.use('/packs/styleguide', express.static(railsRootJoin('design/styleguide')))
})

module.exports = environment.toWebpackConfig()
