const path = require('path')

module.exports = {
  map: {
    annotation: false
  },
  plugins: [
    require('postcss-import'),
    require('postcss-mixins')({
        mixinsDir: path.join(__dirname, './lib/postcss_mixins/')
    }),
    require('postcss-preset-env')({
      stage: 2,
      // https://preset-env.cssdb.org/features/#stage-2
      features: {
        'nesting-rules': true,
        'focus-visible-pseudo-class': false,
        'logical-properties-and-values': false,
        'custom-media-queries':  {
          importFrom: [
            path.join(__dirname, './node_modules/@primer/primitives/tokens-v2-private/css/tokens/functional/size/viewport.css')
          ]
        },
      }
    }),
    process.env.CI === 'true' ? require('cssnano') : null
  ],
};
