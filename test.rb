# # Hack / proof of concept for an automated torrent/sub downloader

require 'rubygems'
require 'bundler'
Bundler.setup
require_relative './lib/freebox_downloader.rb'


# The query
QUERY = "The pianist"

torrents = FreeboxDownloader.query(QUERY)

if torrents.empty?
  puts "No torrents found"
  exit
end

puts "Found torrents : #{torrents.map(&:title)}"

torrent = torrents.first

puts "Chosen torrent #{torrent.title}"

subs = FreeboxDownloader.subs(torrent.torrent_file_url)

if subs.empty?
  puts "Got no subs"
else
  puts "Got subs : #{subs}"
end
