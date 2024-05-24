# Running dev server
Run `./vue.sh` and `./django.sh`
In `vue.sh` you need to specify the correct tocken for api auth

# Setup a new server
1. [Install docker](https://docs.docker.com/engine/install/debian/#install-using-the-repository)
2. Install certbot `sudo apt install certbot`
3. Generate certificates `sudo certbot certonly --standalone`
4. Add user to docker group `sudo usermod -aG docker {username}`
2. Create a `/secrets/db_password.txt`, `/secrets/email_host_password.txt` and `/secrets/secret_key_production.txt` files on the production server
3. Copy ssh public key to `~/.ssh/authorized_keys` (on macos from `~/.ssh/id_rsa.pub`)
1. Run `docker -H ssh://user@IP compose -f docker-compose.yml -f production.yml up -d --build`
4. Create django super user 
```bash
docker exec -ti oboz_studentow_pwr_2023_docker-web-1 bash
python3 manage.py createsuperuser
```
or copy postgress and static volumes `/var/lib/docker/volumes/` if you want to keep the data from the previous server


# Build debuging
Add `--progress=plain` to docker-compose command to see detail messages of building images

# List containers
```bash
docker ps
```

# Logs
```bash
docker logs --tail 100 -f oboz_studentow_pwr_2023_docker-web-1
docker logs --tail 100 -f oboz_studentow_pwr_2023_docker-nginx-1
docker logs --tail 100 -f oboz_studentow_pwr_2023_docker-postgres-1
```
# save logs to file
```bash
docker -H ssh://dockeruser@144.24.177.18:6226 logs --tail 4500 oboz_studentow_pwr_2023_docker-postgres-1 >& ./postgres.log
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

