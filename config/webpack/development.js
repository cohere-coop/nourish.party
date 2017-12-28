const environment = require('./environment')
const KssWebpackPlugin = require('kss-webpack-plugin')

environment.plugins.prepend('Kss', new KssWebpackPlugin({
  source: 'app/assets/src/stylesheets'
}))

module.exports = environment.toWebpackConfig()
