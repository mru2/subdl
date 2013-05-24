# Hack / proof of concept for an automated torrent/sub downloader

require 'rubygems'
require 'bundler'
Bundler.setup


# The query
QUERY = "Game of Thrones S03E03"

# Try to fetch the torrent with most seeds
require 'thepiratebay'

puts "Querying thepiratebay for #{QUERY}"
tpb_res = ThePirateBay::Search.new(QUERY, 0, ThePirateBay::SortBy::Seeders).results.first

puts "Got first result : "
puts tpb_res.map{|k,v|"#{k} : #{v}"}.join("\n")

TITLE = tpb_res[:title]
ID = tpb_res[:torrent_id]
TORRENT_URL = tpb_res[:magnet_link]

# Getting the files for the first result
filenames = ThePirateBay::Torrent.filenames(ID)
puts "Got files : #{filenames.join ';'}"

# Find the right file depending on extension

# Get the subtitles
require 'nokogiri'
