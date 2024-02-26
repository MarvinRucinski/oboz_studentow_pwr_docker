cd vue
export VITE_API_URL='http://localhost:8000/api/'
export VITE_WS_API_URL='ws://localhost:8000/'
# export VITE_API_URL='http://192.168.0.186:8000/api/'
# export VITE_WS_API_URL='ws://192.168.0.186:8000/'
# export VITE_API_URL='http://172.20.10.2:8000/api/'
# export VITE_WS_API_URL='ws://172.20.10.2:8000/'



# admin
# export VITE_AUTH_HEADER='{ "Authorization": "Token 67bdbcffd9c883b098da608f57db393c868ef178" }'
export VITE_AUTH_TOKEN='67bdbcffd9c883b098da608f57db393c868ef178'

# test user
# export VITE_AUTH_HEADER='{ "Authorization": "Token bb2d326dbebc26ac0dec55e96acbb02df83acbba" }'

npx vite --host