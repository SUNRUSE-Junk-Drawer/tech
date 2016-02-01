module.exports =
  entry: "./src/index.coffee"
  output:
    path: "dist"
    filename: "[hash].js"
  module:
    loaders: [
          test: /\.coffee$/
          loader: "coffee-loader"
        ,
          test: /\.png/
          loader: "file-loader"
        ,
          test: /\.sass$/
          loader: (require "extract-text-webpack-plugin").extract "style-loader", "css-loader!sass-loader?indentedSyntax"
      ]
  plugins: [
        new (require "clean-webpack-plugin") "dist"
      ,
        new (require "extract-text-webpack-plugin") "[hash].css"
      ,
        new (require "html-webpack-plugin")
          templateContent: (templateParams, compilation) ->
            require("jade").renderFile "./src/index.jade", templateParams
    ]