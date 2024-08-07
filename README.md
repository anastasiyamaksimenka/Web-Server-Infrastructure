# Web Server Infrastructure

## Overview
This project sets up a two-container infrastructure using Docker Compose. The infrastructure includes a WordPress application and a MySQL database, allowing you to easily deploy and manage your WordPress site. 

## Project Components

### Container 1: WordPress Web Server
- **Image**: Built using `wordpress:latest`.
- **Dockerfile**: Custom Dockerfile in the project folder.
- **Container Name**: `my-awesome-wordpress`.
- **Network**: Custom bridge network named `my-awesome-network`.
- **Port**: Accessible at `http://<VM_IP_ADDRESS>:8080`.
- **Configuration**:
  - WordPress is configured using the `wp-config.php` file.
  - The `wp-config.php` file is copied to `/var/www/html` inside the container.
  - Database configuration in `wp-config.php`:
    - `DB_NAME`: `wordpress`
    - `DB_USER`: `wordpress`
    - `DB_PASSWORD`: `wordpress_password`
    - `DB_HOST`: `my-awesome-database:3306`
  - File ownership:
    - The `wp-config.php` file should be owned by `www-data:www-data` inside the container.
- **Restart Policy**: Always restart in case of failures, except when stopped explicitly.

### Container 2: MySQL Database
- **Image**: `mysql:5.7`.
- **Container Name**: `my-awesome-database`.
- **Network**: Custom bridge network named `my-awesome-network`.
- **Environment Variables**:
  - `MYSQL_ROOT_PASSWORD`: `root_password`
  - `MYSQL_DATABASE`: `wordpress`
  - `MYSQL_USER`: `wordpress`
  - `MYSQL_PASSWORD`: `wordpress_password`
- **Health Check**:
  - Command: `mysqladmin ping -h localhost`
  - Retries: 2
  - Timeout: 5s
  - Interval: 5s
- **Restart Policy**: Always restart in case of failures, except when stopped explicitly.
- **Dependencies**: This container starts before the WordPress container.
- **Data Persistence**: Database files persist even when the container restarts.

## Docker Compose Configuration
The `docker-compose.yml` file orchestrates the setup of both containers and defines the network, volumes, and environment variables necessary for the configuration.

## Setup Instructions

1. **Build and Run Containers**:
   ```sh
   docker-compose up --build
   ```

2. **Access WordPress**:
   Open your browser and navigate to `http://<VM_IP_ADDRESS>:8080` to access the WordPress setup page.

3. **Persistence**:
   Ensure that configuration and database files persist even after container restarts.

## Conclusion
This project provides a seamless setup for running a WordPress site with a MySQL database using Docker Compose. The configuration ensures data persistence, proper networking, and container dependencies to create a robust development environment.
