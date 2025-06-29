# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Rails 8.0.2 application that serves as a Bible reading platform. The project includes:
- King James Version Bible content in XML format (KJV.xml)
- Rails web application with Hotwire (Turbo + Stimulus)
- Tailwind CSS for styling
- SQLite database
- Solid Queue, Solid Cache, and Solid Cable for background jobs, caching, and WebSockets
- Kamal deployment configuration

## Development Commands

### Server & Development
- `bin/rails server` - Start the Rails server
- `bin/dev` or `foreman start -f Procfile.dev` - Start development processes (server + CSS watching)
- `bin/rails tailwindcss:watch` - Watch and rebuild Tailwind CSS on changes
- `bin/rails tailwindcss:build` - Build Tailwind CSS once

### Database
- `bin/rails db:create` - Create databases
- `bin/rails db:migrate` - Run pending migrations
- `bin/rails db:prepare` - Create DB if missing, or run migrations if it exists
- `bin/rails db:seed` - Load seed data
- `bin/rails db:reset` - Drop, recreate, and seed databases

### Testing & Quality
- `bin/rails test` - Run all tests except system tests
- `bin/rails test:system` - Run system tests
- `bin/rails test:db` - Reset database and run tests
- `bundle exec rubocop` - Run RuboCop linter (uses rails-omakase config)
- `bundle exec brakeman` - Run security analysis

### Asset Management
- `bin/rails assets:precompile` - Compile assets for production
- `bin/rails assets:clean` - Remove old compiled assets

## Architecture

### Core Technologies
- **Rails 8.0.2** with Ruby 3.4.4
- **Hotwire Stack**: Turbo Rails + Stimulus for reactive UI without heavy JavaScript
- **Tailwind CSS** for utility-first styling
- **SQLite** as the database (suitable for small to medium applications)
- **Solid Stack**: Queue, Cache, and Cable for modern Rails infrastructure

### Application Structure
- Standard Rails MVC structure
- Uses Propshaft for asset pipeline (modern replacement for Sprockets)
- Importmap for JavaScript module management
- PWA-ready with service worker and manifest support

### Data Model
- Contains KJV Bible data in XML format
- Structure: `<bible>` → `<b n="book">` → `<c n="chapter">` → `<v n="verse">`
- XML format allows for structured biblical text parsing and display

### Deployment
- Configured for Kamal deployment (Docker-based)
- Uses Thruster for HTTP caching and compression in production
- Solid infrastructure reduces external dependencies

## Ruby & Rails Configuration

- **Ruby Version**: 3.4.4 (specified in .ruby-version)
- **Code Style**: Uses rubocop-rails-omakase for consistent Ruby styling
- **Security**: Brakeman configured for vulnerability scanning
- **Testing**: Standard Rails testing with Capybara and Selenium for system tests