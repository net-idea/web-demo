# Setup Guide for Web Demo

This guide provides detailed instructions for setting up and running the Web Demo project.

## Prerequisites

Before you begin, ensure you have the following installed on your system:

- **PHP 8.2 or higher** with required extensions (see composer.json)
- **Composer** (latest version recommended)
- **Node.js** 18+ and **npm** (or Yarn)
- **Docker and Docker Compose** (optional, for containerized setup)
- **Git**

## Installation Methods

### Method 1: Quick Start with Shell Script (Recommended)

This is the fastest way to get started for local development:

```bash
# Clone the repository
git clone https://github.com/net-idea/web-demo.git
cd web-demo

# Make the start script executable
chmod +x start-dev.sh

# Run the startup script
./start-dev.sh
```

The script will:
1. Check prerequisites (PHP, Composer, npm)
2. Install PHP dependencies via Composer
3. Install Node.js dependencies via npm
4. Build frontend assets with Webpack Encore
5. Clear Symfony cache
6. Start Webpack Dev Server (with hot reload)
7. Start Symfony Development Server

Access the application at **http://127.0.0.1:8000**

Press `Ctrl+C` to stop all servers.

### Method 2: Docker Compose Setup

For a fully containerized environment:

```bash
# Clone the repository
git clone https://github.com/net-idea/web-demo.git
cd web-demo

# Start all containers
docker-compose up -d

# Build frontend assets (first time only)
docker-compose exec node npm run build
```

Access the application at **http://localhost:8000**

#### Docker Management Commands

```bash
# View logs
docker-compose logs -f

# Stop all containers
docker-compose down

# Rebuild containers
docker-compose up -d --build

# Execute PHP commands
docker-compose exec app php bin/console cache:clear

# Execute npm commands
docker-compose exec node npm run dev

# Access database
docker-compose exec db mysql -u web_demo -pweb_demo web_demo
```

### Method 3: Manual Setup

For full control over the setup process:

#### Step 1: Clone and Install Dependencies

```bash
# Clone the repository
git clone https://github.com/net-idea/web-demo.git
cd web-demo

# Install PHP dependencies
composer install

# Install Node.js dependencies
npm install
```

#### Step 2: Configure Environment

```bash
# Copy environment file (if not exists)
cp .env .env.local

# Edit .env.local with your settings
# Example:
# APP_ENV=dev
# APP_SECRET=your-secret-key-here
# DATABASE_URL="mysql://user:pass@127.0.0.1:3306/web_demo"
# MAILER_DSN=smtp://localhost:1025
```

#### Step 3: Build Frontend Assets

```bash
# For development
npm run dev

# For production
npm run build

# Watch mode (auto-rebuild on changes)
npm run watch
```

#### Step 4: Start the Application

```bash
# Start Symfony development server
php -S 127.0.0.1:8000 -t public

# Or use Symfony CLI (if installed)
symfony serve

# In another terminal, start Webpack dev server (optional, for hot reload)
npm run dev-server
```

Access the application at **http://127.0.0.1:8000** or **http://127.0.0.1:8080** (with dev server)

## Available Pages

After setup, you can access:

- **Home**: http://127.0.0.1:8000/
- **About**: http://127.0.0.1:8000/about
- **Services**: http://127.0.0.1:8000/service
- **Contact**: http://127.0.0.1:8000/kontakt

## Development Workflow

### Frontend Development

```bash
# Watch for changes and auto-rebuild
npm run watch

# Start dev server with hot reload
npm run dev-server

# Build for production
npm run build
```

### Backend Development

```bash
# Clear cache
php bin/console cache:clear

# List all routes
php bin/console debug:router

# List all services
php bin/console debug:container

# Database migrations (if using database)
php bin/console doctrine:migrations:migrate
```

### Adding New Content Pages

1. Create a markdown file in the `content/` directory:
   ```bash
   # Example: content/faq.md
   echo "# FAQ" > content/faq.md
   echo "Questions and answers..." >> content/faq.md
   ```

2. The page will be automatically available at `/faq`

3. Link to it from other pages:
   ```twig
   <a href="{{ path('web_base_page', {slug: 'faq'}) }}">FAQ</a>
   ```

### Customizing Styles

Edit `assets/styles/app.scss` to add your custom styles:

```scss
// Add your custom styles here
.my-custom-class {
    background-color: #f0f0f0;
    padding: 20px;
}
```

The styles will be automatically compiled when running `npm run watch` or `npm run build`.

### Overriding Templates

To customize the appearance, create or edit templates in the `templates/` directory:

```twig
{# templates/pages/my-page.html.twig #}
{% extends 'base.html.twig' %}

{% block title %}My Custom Page{% endblock %}

{% block body %}
    <div class="container">
        <h1>My Custom Page</h1>
        <p>Custom content goes here</p>
    </div>
{% endblock %}
```

## Configuration

### Bundle Configuration

Edit `config/packages/web_base.yaml` to customize the website:

```yaml
net_idea_web_base:
  company:
    name: 'Your Company Name'
    email: 'info@yourcompany.com'
    phone: '+1 234 567 8900'
    street: 'Your Street Address'
    city: 'Your City'
    zip: '12345'
    country: 'Your Country'
  site:
    base_url: 'https://yourwebsite.com'
    brand_name: 'Your Brand'
    site_name: 'Your Site Name'
    default_description: 'Your site description'
  mail:
    from_address: 'noreply@yourcompany.com'
    from_name: 'Your Company'
    to_address: 'contact@yourcompany.com'
    to_name: 'Contact Team'
```

### Webpack Encore Configuration

Edit `webpack.config.js` to customize the build process:

```javascript
Encore
    // Add more entry points
    .addEntry('admin', './assets/admin.js')
    
    // Add more aliases
    .addAliases({
        '@components': path.resolve(__dirname, 'assets/components'),
    })
    
    // Enable other loaders
    .enablePostCssLoader()
;
```

## Troubleshooting

### Common Issues

#### Port 8000 Already in Use
```bash
# Use a different port
php -S 127.0.0.1:8001 -t public
```

#### Webpack Build Fails
```bash
# Clear node_modules and reinstall
rm -rf node_modules package-lock.json
npm install
npm run build
```

#### Symfony Cache Issues
```bash
# Clear cache with full permissions reset
php bin/console cache:clear
chmod -R 777 var/cache var/log
```

#### Template Not Found
```bash
# Make sure to clear cache after creating new templates
php bin/console cache:clear
```

#### Database Connection Issues
```bash
# Check your DATABASE_URL in .env.local
# Make sure the database exists
php bin/console doctrine:database:create
```

## Production Deployment

For production deployment:

1. **Set environment to production**:
   ```bash
   # In .env.local
   APP_ENV=prod
   APP_DEBUG=0
   ```

2. **Build optimized assets**:
   ```bash
   npm run build
   ```

3. **Clear and warm up cache**:
   ```bash
   php bin/console cache:clear --env=prod
   php bin/console cache:warmup --env=prod
   ```

4. **Set proper permissions**:
   ```bash
   chmod -R 755 var/cache var/log
   chown -R www-data:www-data var/cache var/log
   ```

5. **Configure web server** (Nginx/Apache) to point to `public/` directory

## Additional Resources

- [Symfony Documentation](https://symfony.com/doc/current/index.html)
- [Webpack Encore Documentation](https://symfony.com/doc/current/frontend.html)
- [Bootstrap 5 Documentation](https://getbootstrap.com/docs/5.3/)
- [NetIdea WebBase GitHub](https://github.com/net-idea/web-base)

## Support

For issues and questions:
- Create an issue on [GitHub](https://github.com/net-idea/web-demo/issues)
- Check the [NetIdea WebBase documentation](https://github.com/net-idea/web-base)
