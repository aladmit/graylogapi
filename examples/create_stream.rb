require 'graylogapi'

graylogapi = Graylog.new('http://localhost:9000/api', 'username', 'password')

# find index_id of default index
index_id = graylogapi.system.index_sets.all['index_sets'].find { |i| i['default'] == true }['id']

# create stream
stream = graylogapi.streams.create(title: 'new stream', index_set_id: index_id, rules: [])

# resume stream
graylogapi.streams.resume(stream['stream_id'])
