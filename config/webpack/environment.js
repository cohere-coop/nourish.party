const { environment } = require('@rails/webpacker')
const _ = require('lodash')
const eyeglass = require('eyeglass')

// add eyeglass to sass-loader config
const sassLoaderChain = environment.loaders.get('sass')
const baseSassLoaderConfig = _.find(sassLoaderChain.use, config => config.loader === 'sass-loader')
baseSassLoaderConfig.options = eyeglass({
  ...baseSassLoaderConfig.options,
  eyeglass: {}
})

module.exports = environment
