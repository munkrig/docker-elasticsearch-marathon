#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'uri'

marathon_url = ARGV[0]
app_id = ARGV[1]

tasks_url = "#{marathon_url}/v2/apps/#{app_id}/tasks"

uri = URI.parse(tasks_url)
http = Net::HTTP.new(uri.host, uri.port)

request = Net::HTTP::Get.new(uri.path)
request['Content-Type'] = 'application/json'
request['Accept'] = 'application/json'

response = http.request(request)

data = JSON.parse(response.body)
print data['tasks'].map { |t| "#{t['host']}:#{t['ports'].first}" }.join(',')
