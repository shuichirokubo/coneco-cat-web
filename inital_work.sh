
#!/bin/bash

mysql-ctl start

bundle exec rake db:migrate

bundle exec rails s -b $IP -p $PORT
