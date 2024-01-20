# change WG_HOST in docker-compose.yml

- need to do this to stop systemd-resolve from listening on port 53 
    - https://unix.stackexchange.com/questions/676942/free-up-port-53-on-ubuntu-so-costom-dns-server-can-use-it

- install docker 

'''bash
    docker compose up -d
'''

pihole 
    `http://summry.me:8080/admin`

wireguard
    `https://summry.me`


[Run Wireguard behind nginx with SSL](https://github.com/wg-easy/wg-easy/wiki/Using-WireGuard-Easy-with-nginx-SSL ):

1. run certbot inside container 
    ```bash
    docker exec -it nginx /bin/sh

    cp /etc/nginx/servers/wg-easy.conf /etc/nginx/conf.d/. ; certbot --nginx --non-interactive --agree-tos -m webmaster@google.com -d summry.me ; nginx -s reload
    ```