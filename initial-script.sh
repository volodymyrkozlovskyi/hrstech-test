#! bash

echo "rename/copy files .env in api-1 and api-2"
  mv devops-test/api-1/.env.example devops-test/api-1/.env
  mv devops-test/api-2/.env.example devops-test/api-2/.env

echo "change database.php configuration"
  sed -i 's/3308/3306/g' devops-test/api-1/config/database.php
  sed -i '0,/127\.0\.0\.1/s//mysql/' devops-test/api-1/config/database.php

echo "changing app.php conf"
  sed -i '0,/'localhost:8100'/s//web_private:80/' devops-test/api-1/config/app.php

echo "changing permissions for api-1"
  sudo chown -R 82:82 devops-test/api-1/
  
echo "add current user with full permissions for api-1 folder" 
  sudo find devops-test/api-1/ -type d -exec setfacl -m u:$USER:rwx {} \;
  sudo find devops-test/api-1/ -type f -exec setfacl -m u:$USER:rw {} \;
  
echo "changing permissions for api-2"
  sudo chown -R 82:82 devops-test/api-2/
  
echo "add current user with full permissions for api-2 folder" 
  sudo find devops-test/api-2/ -type d -exec setfacl -m u:$USER:rwx {} \;
  sudo find devops-test/api-2/ -type f -exec setfacl -m u:$USER:rw {} \;

echo "initial docker commands for api 1"
  sudo docker exec api-1 php artisan key:generate
  sudo docker exec api-1 php artisan migrate --force
  sudo docker exec api-1 php artisan db:seed --force

echo "initial docker commands for api 2"
  sudo docker exec api-2 php artisan key:generate



