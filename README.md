Create a `/secrets/db_password.txt` and `/secrets/secret_key_production.txt` files on the production server

Generate certificates: 
docker compose run --rm certbot certonly --webroot --webroot-path /var/www/certbot -d appka.obozstudentowpwr.com -d apka.obozstudentowpwr.com
certbot certonly --webroot --webroot-path /var/www/certbot/ -d test.obozstudentowpwr.com -m marvin@prasa-polska.com --agree-tos --staple