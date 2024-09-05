sudo usermod -a -G www-data $USER
sudo find . -type f -exec chmod 644 {} \;
sudo find . -type d -exec chmod 755 {} \;
sudo chown -R $USER:www-data .


sudo chgrp -R www-data storage bootstrap/cache
sudo chmod -R ug+rwx storage bootstrap/cache
sudo chmod -R 775 storage bootstrap/cache/

sudo chmod -R 775 public/uploads