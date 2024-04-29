sh script to set up web servers to deploy web_static

# Update package index and install Nginx
sudo apt-get update
sudo apt-get -y install nginx

# Create directories for web_static
sudo mkdir -p /data/web_static/shared/
sudo mkdir -p /data/web_static/releases/test/

# Create a simple HTML file for testing
echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" | sudo tee /data/web_static/releases/test/index.html

# Create a symbolic link to the new version
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# Change ownership of /data directory to ubuntu user
sudo chown -R ubuntu:ubuntu /data

# Add a new location block to Nginx configuration
# This block serves static content from /data/web_static/current directory
sudo sed -i '53i \\tlocation \/hbnb_static {\n\t\t alias /data/web_static/current;\n\t}' /etc/nginx/sites-available/default

# Restart Nginx to apply changes
sudo service nginx restart

