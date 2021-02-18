require "logger"

log = Logger.new(STDOUT)
log.info "hi"
STDOUT.flush
sleep 3
log.info "ho"