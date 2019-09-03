every 2.minutes do
  runner 'PagespeedResultDaily.get', output: 'log/pagespeed_result_daily.log'
end