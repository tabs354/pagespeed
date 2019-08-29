every 1.day, at: "3:00 am" do
  runner 'PagespeedResultDaily.get', :environment => "development" ,:output => 'log/pagespeed_result_daily.log'
end