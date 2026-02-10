const Encore = require('@symfony/webpack-encore');
const path = require('path');

// Manually configure the runtime environment if not already configured yet by the "encore" command.
// It's useful when you use tools that rely on webpack.config.js file.
if (!Encore.isRuntimeEnvironmentConfigured()) {
    Encore.configureRuntimeEnvironment(process.env.NODE_ENV || 'dev');
}

Encore
    // directory where compiled assets will be stored
    .setOutputPath('public/build/')
    // public path used by the web server to access the output path
    .setPublicPath('/build')
    
    // Main application entry
    .addEntry('app', './assets/app.js')
    
    // Enable single runtime chunk
    .enableSingleRuntimeChunk()
    
    // Clean output folder before build
    .cleanupOutputBeforeBuild()
    
    // Enable source maps during development
    .enableSourceMaps(!Encore.isProduction())
    
    // Enable versioning in production
    .enableVersioning(Encore.isProduction())
    
    // Enable Sass/SCSS loader
    .enableSassLoader()
    
    // Enable TypeScript loader
    .enableTypeScriptLoader()
    
    // Add alias for web-base frontend
    .addAliases({
        '@web-base': path.resolve(__dirname, 'packages/web-base/frontend'),
    })
;

module.exports = Encore.getWebpackConfig();
