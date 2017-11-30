#!/usr/bin/env ruby
# frozen_string_literal: true

require 'dotenv'
require 'json'
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

  # video description
  puts "video.title: #{video.title}"
  puts "video.published_at: #{video.published_at}"
  puts "video.description: #{video.description}"
  puts "video.tags: #{video.tags}"
  puts "video.channel_id: #{video.channel_id}"
  puts "video.channel_title: #{video.channel_title}"
  puts "video.category_id: #{video.category_id}"
  puts "video.category_title: #{video.category_title}"

  # video statistics
  puts "video.view_count: #{video.view_count}"
  puts "video.like_count: #{video.like_count}"
  puts "video.dislike_count: #{video.dislike_count}"
  puts "video.favorite_count: #{video.favorite_count}"
  puts "video.comment_count: #{video.comment_count}"

  video.comment_threads.each do |comment_thread|
    sentiment = @analyzer.sentiment comment_thread.text_display
    score = @analyzer.score comment_thread.text_display
    puts "#{sentiment}|#{score}|#{comment_thread.text_display}"
  end
end

initialize

Dir['input/*'].each do |filename|
  videos = fetch_videos(filename)
  puts "#{videos['title']}#{videos['videos']}"
  videos['videos'].each_value do |v|
    fetch_youtube_stats v
  end
end
