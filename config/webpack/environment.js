const { environment } = require("@rails/webpacker");

// Use jQuery and Bootstap's JS
const webpack = require("webpack");
environment.plugins.prepend(
  "Provide",
  new webpack.ProvidePlugin({
    $: "jquery",
    jQuery: "jquery",
    Popper: "popper.js",
  })
);

module.exports = environment;
