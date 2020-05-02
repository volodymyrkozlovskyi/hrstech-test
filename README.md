# hrstech-test

				This is my solution to given home assignment for DevOps position.
To check how it works please make a git clone request on your system. Before you proceed, please make sure you have docker and docker compose installed on your System.
After you’ve pulled this repository to any of your directories, switch inside of it.
Next step will be to clone the repository which I was provided by a company representative. (The copy of that repository with api's should be inside of my repository)

      git clone https://github.com/volodymyrkozlovskyi/hrstech-test.git
      cd hrstech-test
      git clone https://github.com/codysnider/devops-test.git

Next step will be to run sudo docker-compose build and docker compose up -d. In my solution the only service which will have forwarded ports is  nginx_api-1, please make sure your system has ports 80 and 443 available for mapping, or make appropriate changes in docker-compose file.

After all containers are up and running (give them at least a minute or two), please run sudo bash initial-script.sh. This script needs to be executed only once during initial setup. It will change some settings for php as well as permissions for folders with api's.
This is it, now you can access api-1 simply by typing ip in the browser address line.

Short overview of what is done in docker compose file:
I decided to go with separate containers for each service, in my opinion this is how docker needs to be used - one container for one service. I declared two networks. One is public for nginx web server, which will be serving api-1. The second network is private, the rest of the containers are located in it and do not have any ports exposed to the outside. Web servers, as well as api servers, have mounted volumes to the main filesystem, so data stays persistent and in dev environment developers can apply changes directly to files on their system and see changes right away. I also included composer containers for each api. This way, if developer needs to install additional modules on any of api’s, he can just simply run the command to restart composer container. In case if he wants to run compose update, we need to make a little change in docker-compose.yml change ["composer", "install"] to ["composer", "update"].

To launch this in production we go different ways, I will talk about possible solutions in AWS:

1) We can just simply launch this docker compose on our EC2 with public IP, andin Route 53 service we can forward our 	domain/subdomain to our EC2.

2) Assuming that the first solution is not that good if on the same EC2 instance we have different public containers. And they will be accessible from outside under different subdomains. In addition to solution 1 we need to configure reverse in front that will later forward our requests to different ports on containers. In that case we need to modify our docker compose to forward containers ports to something else but not 80 and 443 or other reserved ports.

Of course there are a couple more options with ECS and ELB, and I can implement any of these. And if we are going to use ECS we will need to slightly modify a compose file.

Please let me know if you would like me to make any additional instructions or modifications to a specific environment.
