every 1.day at: '3:00 am' do
  runner 'PagespeedResultDaily.get', :output => 'log/check_status_update.log'
end