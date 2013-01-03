#!/usr/bin/env ruby
require 'fileutils'

def readfile(path)
  File.file?(path) ? File.open(path) { |f| f.read } : ''
end

def add_gsd!
  File.open(hostfile, 'a') do |file|
    file.puts ""
    gsd.each do |line|
      file.puts line
    end
  end
end

def remove_gsd!(start_token='## start-gsd', end_token='## end-gsd')
  contents = readfile(hostfile)
  contents.gsub!(/#{start_token}(.*)#{end_token}/m,'')
  contents.strip!     # remove ending whitespace
  contents << "\r\n"  # adding a nice ending newline

  File.open(hostfile, 'w') do |file|
    file.write contents
  end
end

def gsd(start_token='## start-gsd', end_token='## end-gsd')
  content = []
  content << start_token
  hosts.each do |host|
    content << "127.0.0.1  #{host}"
    content << "127.0.0.1  www.#{host}"
  end
  content << end_token
end

def hosts
  #"foo.com, bar.com, baz.com".split(',').collect!{ |h| h.strip }
  local = readfile(File.join(File.expand_path('~'), '.blockhosts'))

  unless local.empty?
    local.split(/\r\n|\n/).collect!{ |h| h.strip }
  else
    ['reddit.com','news.ycombinator.com']
  end
end

def hostfile
  File.join('/etc/hosts')
end

def flushcache
  `dscacheutil -flushcache`
end

if __FILE__ == $0
  return_flag = "ERROR: Run with sudo" unless ENV['USER'] == 'root'

  if return_flag
    puts return_flag
  else
    case ARGV[0]
    when "work"
      remove_gsd!
      add_gsd!
      flushcache
    when "play"
      remove_gsd!
      flushcache
    else
      puts "Usage:"
      puts "  sudo get-shit-done.rb work"
      puts "  sudo get-shit-done.rb play"
    end
  end
end
