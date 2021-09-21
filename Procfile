web: bin/rails server -p ${PORT:-5000} -e $RAILS_ENV
resque: QUEUE=* rake rake schedule_and_work