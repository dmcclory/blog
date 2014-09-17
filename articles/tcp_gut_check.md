---
slug: tcp_gut_check
title: Gut check: TCP socket timings
date: 2014-09-17
category: programming
---
# How long to create a TCP socket on a normal day?

I got curious about this question this morning, so to test it out, I wrote some simple code:

```
# the server
# (literally the server from the RI docs on TCPServer)
require 'socket'

server = TCPServer.new 4000

loop do
  client = server.accept
  client.puts "Hello!"
  client.close
end

```

```
# the client
# (essentially the client example from RI docs on TCPSocket)
require 'socket'

address = ARGV[0] || "localhost"
port    = ARGV[1] || 4000

start = Time.now
s = TCPSocket.new address, port
post_create = Time.now
s.close
puts "duration: #{post_create - start}"
```

I put them on 2 digital ocean boxes; one on the east coast, one on the west, and ran it 9 times. Results! It takes an average of 0.0828s to establish a TCP connection across the US, less a little bit for the Ruby overhead.
