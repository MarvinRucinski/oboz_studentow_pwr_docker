# Running dev server
Run `./vue,sh` and `./django.sh`
In `vue.sh` you need to specfy thbe correct tocken for api auth

# Setup a new server
1. Install docker
2. Add user to docker group `sudo usermod -aG docker {username}`
2. Create a `/secrets/db_password.txt` and `/secrets/secret_key_production.txt` files on the production server
3. Copy ssh public key to `~/.ssh/authorized_keys` (on macos from `~/.ssh/id_rsa.pub`)
4. Copy postgress and static volumes `/var/lib/docker/volumes/`
4. Run and generate certificates
5. Make a symlink `docker exec -ti oboz_studentow_pwr_2023_docker-nginx-1 bash`

    `ln -s /etc/letsencrypt/live/test3.obozstudentowpwr.com/ /etc/letsencrypt/live/appka.obozstudentowpwr.com`

Generate certificates: 
```bash
docker compose run --rm certbot certonly --webroot --webroot-path /var/www/certbot -d appka.obozstudentowpwr.com -d apka.obozstudentowpwr.com

certbot certonly --webroot --webroot-path /var/www/certbot/ -d test.obozstudentowpwr.com -m marvin@prasa-polska.com --agree-tos --staple

docker compose run --rm certbot certonly --webroot --webroot-path /var/www/certbot/ -d "*.obozstudentowpwr.com" -m marvin@prasa-polska.com --agree-tos --staple
```

# Build ebuging
Add `--progress=plain` to docker-compose command to see detail messages of building images

# List containers
```bash
docker ps
```

# Logs
```bash
docker logs --tail 10 -f oboz_studentow_pwr_2023_docker-web-1
docker logs --tail 10 -f oboz_studentow_pwr_2023_docker-nginx-1
```

# Connect to container
```bash
docker exec -ti oboz_studentow_pwr_2023_docker-nginx-1 bash
docker exec -ti oboz_studentow_pwr_2023_docker-web-1 bash
```

# Backup database
```bash
docker exec -ti oboz_studentow_pwr_2023_docker-postgres-1 bash
pg_dumpall -c -U dbuser > dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql
ctrl + d
sudo docker cp oboz_studentow_pwr_2023_docker-postgres-1:filename.sql ~/filename.sql
```

# Backup media
```bash
    sudo docker cp oboz_studentow_pwr_2023_docker-web-1:/www/media ~/
```

# Download backup
```bash
    zip -r backup-30-08-2023.zip ./
    scp -P 6226 marvinr@appka.obozstudentowpwr.com:"/home/marvinr/backup-30-08-2023.zip" Downloads/
```

