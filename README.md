# Wireguard-Pihole-Unbound-Docker

```bash
./install_docker.sh
```
* update & upgrade system packages
* install dns/network packages
* install docker & add current user to docker group


```bash
./update_dns_config.sh
```
* EC2 has a process that listens on port 53 but that's needed for pihole, stop it.


```bash
sudo reboot
```
* restart so changes take effect


```bash
vim .env
```
* change variables in .env file which are used in docker-compose.yml

```bash
./start_containers
```
* calls `docker-compose.yml` with the following containers communicating on a macvlan network
    1. wireguard
        * UI runs on port 51821
            * nginx reverse proxy listens on `0.0.0.0` & forwards to `localhost:51821`
            * https://summry.me
        * VPN runs on port 51820

    2. pihole
        * UI on port 8080
            * `http://summry.me:8080/admin`
        * DNS on port 53

    3. unbound 
        * port 5335

    4. nginx
        * run certbot inside nginx container to add certs to wireguard UI. pihole cant run on localhost?
            ```bash
            docker exec -it nginx /bin/sh

            cp /etc/nginx/servers/wg-easy.conf /etc/nginx/conf.d/. ; certbot --nginx --non-interactive --agree-tos -m webmaster@google.com -d summry.me ; nginx -s reload
            ```
* the only ports exposed to the internet in the container
    * TCP 
        80
        443
    * UDP
        * 51820

```bash
./stop_containters
```
* stops containers and DELETES ALL IMAGES

    

---
[Run Wireguard behind nginx with SSL](https://github.com/wg-easy/wg-easy/wiki/Using-WireGuard-Easy-with-nginx-SSL)


#### Commands
--- 
- check if connection to UDP port can be established 
    netcat -u -z -v localhost 51820