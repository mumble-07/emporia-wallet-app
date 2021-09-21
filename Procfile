web: bin/rails server -p ${PORT:-5000} -e $RAILS_ENV
resque: QUEUE=* rake resque:work
scheduler: bundle exec rake environment=production resque:scheduler