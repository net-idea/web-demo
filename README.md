# Web Demo

Basic website demo using the web-base library based on Symfony and Bootstrap.

This is a demonstration project showcasing the [NetIdea WebBase](https://github.com/net-idea/web-base) library - a reusable Symfony bundle for building modern corporate websites.

## Features

- 🚀 **Modern Stack**: Symfony 6.4, Bootstrap 5, Webpack Encore
- 📱 **Responsive Design**: Mobile-first Bootstrap 5 design
- 🎨 **Theme Toggle**: Dark/light mode support
- 📧 **Contact Form**: Built-in contact form with validation
- 🔧 **Easy Setup**: Docker/Docker Compose and shell script for quick start
- 📦 **Modular**: Reusable components from NetIdea WebBase library

## Demo Pages

- **Home** (`/`): Landing page with hero section and features
- **About** (`/about`): About page with markdown content
- **Services** (`/service`): Services overview page
- **Contact** (`/contact`): Contact form with email notifications

## Requirements

- PHP 8.2 or higher
- Composer
- Node.js 18+ and npm
- Docker and Docker Compose (for containerized setup)

## Quick Start

### Option 1: Local Development (Shell Script)

```bash
# Clone the repository
git clone https://github.com/net-idea/web-demo.git
cd web-demo

# Run the development startup script
./start-dev.sh
```

The script will:
1. Install PHP dependencies (Composer)
2. Install Node.js dependencies (npm)
3. Build frontend assets
4. Start Webpack Dev Server
5. Start Symfony Development Server

Access the application at: **http://127.0.0.1:8000**

### Option 2: Docker Compose

```bash
# Clone the repository
git clone https://github.com/net-idea/web-demo.git
cd web-demo

# Start the containers
docker-compose up -d

# Build frontend assets (first time)
docker-compose exec node npm run build
```

Access the application at: **http://localhost:8000**

### Option 3: Manual Setup

```bash
# Clone the repository
git clone https://github.com/net-idea/web-demo.git
cd web-demo

# Install PHP dependencies
composer install

# Install Node.js dependencies
npm install

# Build frontend assets
npm run build

# Start Symfony development server
php -S 127.0.0.1:8000 -t public

# In a separate terminal, start Webpack dev server (optional)
npm run dev-server
```

## Development

### Frontend Development

```bash
# Watch for changes and rebuild automatically
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

# Check routes
php bin/console debug:router

# Check services
php bin/console debug:container
```

## Project Structure

```
web-demo/
├── assets/                 # Frontend assets
│   ├── app.js             # Main JavaScript entry
│   └── styles/            # SCSS styles
├── config/                # Symfony configuration
│   ├── packages/          # Bundle configurations
│   └── routes/            # Route definitions
├── content/               # Markdown content files
│   ├── about.md
│   └── service.md
├── docker/                # Docker configuration
│   ├── nginx/             # Nginx config
│   └── php/               # PHP config
├── packages/              # Local packages
│   └── web-base/          # NetIdea WebBase library
├── public/                # Public web directory
│   ├── build/             # Compiled assets
│   └── index.php          # Front controller
├── src/                   # Application code
│   └── Controller/        # Controllers
├── templates/             # Twig templates
│   ├── base.html.twig     # Base template
│   └── pages/             # Page templates
├── var/                   # Cache and logs
├── docker-compose.yml     # Docker Compose config
├── Dockerfile             # Docker image config
├── package.json           # Node.js dependencies
├── composer.json          # PHP dependencies
├── webpack.config.js      # Webpack Encore config
└── start-dev.sh           # Development startup script
```

## Configuration

### Web Base Bundle

Configure the bundle in `config/packages/web_base.yaml`:

```yaml
net_idea_web_base:
  company:
    name: 'Your Company'
    email: 'info@example.com'
  site:
    base_url: 'https://example.com'
    brand_name: 'Your Brand'
```

### Environment Variables

Create a `.env.local` file for local configuration:

```env
APP_ENV=dev
APP_SECRET=your-secret-key
MAILER_DSN=smtp://localhost:1025
```

## Customization

### Adding New Pages

1. Create a markdown file in `content/` directory
2. The page will be automatically available via the WebBase bundle routes

### Overriding Templates

Create your templates in `templates/` directory:

```twig
{# templates/pages/custom.html.twig #}
{% extends 'base.html.twig' %}

{% block body %}
    <div class="container">
        <h1>Custom Page</h1>
    </div>
{% endblock %}
```

### Custom Styles

Add your custom styles in `assets/styles/app.scss`:

```scss
.my-custom-class {
    color: #333;
}
```

## Docker Commands

```bash
# Start containers
docker-compose up -d

# Stop containers
docker-compose down

# View logs
docker-compose logs -f

# Execute commands in container
docker-compose exec app php bin/console cache:clear
docker-compose exec node npm run build

# Rebuild containers
docker-compose up -d --build
```

## Technologies Used

- **Backend**
  - PHP 8.3
  - Symfony 6.4
  - Twig templating
  - Composer

- **Frontend**
  - Bootstrap 5.3
  - Webpack Encore 4.0
  - Sass/SCSS
  - JavaScript (ES6+)

- **DevOps**
  - Docker
  - Docker Compose
  - Nginx
  - PHP-FPM

## License

MIT

## Credits

Built using [NetIdea WebBase](https://github.com/net-idea/web-base) library.

