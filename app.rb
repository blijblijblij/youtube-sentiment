#!/usr/bin/env ruby
# frozen_string_literal: true

require 'csv'
require 'dotenv'
require 'json'
require 'loofah'
require 'sentimental'
require 'yt'

# clear the console terminal
system('clear')
puts 'youtube video analyzer'

def initialize
  # Read environment variables from file
  Dotenv.load

  # configure the youtube gem
  Yt.configure do |config|
    config.log_level = :debug
    config.api_key = ENV['YT_API_KEY']
  end

  # initialize sentiment analyzer
  @analyzer = Sentimental.new
  @analyzer.load_defaults
end

def fetch_videos(filename)
  puts "---> read #{filename}"
  file = File.read(filename)
  JSON.parse(file)
end

def fetch_youtube_stats(video_id)
  video = Yt::Video.new id: video_id
  v = {}

  # video description
  v['video_id'] = video_id
  v['video.title'] = Loofah.fragment(video.title).text
  v['video.published_at'] = video.published_at
  v['video.tags'] = video.tags
  v['video.channel_id'] = video.channel_id
  v['video.category_id'] = video.category_id
  v['video.category_title'] = video.category_title
  v['video.view_count'] = video.view_count
  v['video.like_count'] = video.like_count
  v['video.dislike_count'] = video.dislike_count
  v['video.favorite_count'] = video.favorite_count
  v['video.comment_count'] = video.comment_count

  # video comments
  c = []
  video.comment_threads.each do |comment_thread|
    # clean the comment from html mayhem
    comment = Loofah.fragment(comment_thread.text_display).text
    score = @analyzer.score comment
    c << score
  end
  len = c.length
  if len > 2
    v['lowest'] = c.min
    v['highest'] = c.max
    total = c.inject(:+)
    v['average'] = total.to_f / len
    sorted = c.sort
    v['median'] = len.odd? ? sorted[len / 2] : (sorted[len / 2 - 1] + sorted[len / 2]).to_f / 2
  end
  puts v.to_s
  v
end

initialize
CSV.open('data.csv', 'a+', {:col_sep => "####"}) do |csv|
  Dir['input/*'].each do |filename|
    videos = fetch_videos(filename)
    puts "#{videos['title']}#{videos['videos']}"
    videos['videos'].each_value do |v|
      t = fetch_youtube_stats v
      csv << t.values
    end
  end
end
