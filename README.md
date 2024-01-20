# change WG_HOST in docker-compose.yml

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



# docker compose down ; docker rmi -f $(docker images -aq)
#  docker compose up -d ; sudo netstat -lntp