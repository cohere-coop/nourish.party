const environment = require('./environment')
const path = require('path')
const KssWebpackPlugin = require('kss-webpack-plugin')

function railsRootJoin (pathname) {
  return path.join(__dirname, '..', '..', pathname)
}

function styleguideRelativePath (pathname) {
  return path.join(environment.config.output.path, pathname)
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

module.exports = environment.toWebpackConfig()
