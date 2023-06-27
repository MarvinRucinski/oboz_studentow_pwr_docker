cd vue
export VITE_API_URL='http://192.168.0.34:8000/api/'

# admin
export VITE_AUTH_HEADER='{ "Authorization": "Token REMOVED" }'

# test user
# export VITE_AUTH_HEADER='{ "Authorization": "Token bb2d326dbebc26ac0dec55e96acbb02df83acbba" }'

npx vite --host