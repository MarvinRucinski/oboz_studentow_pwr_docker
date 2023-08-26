from datetime import datetime

with open('/version.txt', 'w') as f:
    f.write(datetime.now().strftime('%Y-%m-%d %H:%M:%S'))
    f.close()