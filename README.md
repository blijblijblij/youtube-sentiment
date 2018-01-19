[![Dependency Status](https://beta.gemnasium.com/badges/github.com/blijblijblij/youtube-sentiment.svg)](https://beta.gemnasium.com/projects/github.com/blijblijblij/youtube-sentiment)

# youtube-sentiment

An experiment to figure out how to interact with the youtube data api, gathering statistical information on videos.

- utilize the youtube data  (v3)
- get metrics on a curated list of videos
- measure the sentiment on youtube user comment to those videos
- profit!

## Instructions

Get the gems
```
bundle install
```

Generate an google api key for the youtube data api and make that available as an enviroment either by exporting:

```
export YT_API_KEY=zjhfsdjhfgsjdhfgjshdfgs
```

Or by adding it the a `.env` file in the root folder of this project.

Then run:

```
ruby app.rb
```

Which outputs:

```
video.title: Collection of Oscar's Oasis Best Cartoon 2016, oscar jobs
video.published_at: 2017-05-05 07:09:00 UTC
video.description: Collection of Oscar's Oasis Best Cartoon 2016, oscar jobs

Episode animated Oscar's Oasis Best for children. Hilarious footage that I've ever seen. Having fun.
video.tags: ["Lizard Oscar job", "Gecko Oscar job", "Oscar lizard job", "oscar gecko job", "lizard oscar", "gecko oscar", "oscar 's oasis", "oscar oasis", "oscar s oasis", "oscar 's oasis cartoon 2016", "oscar 's oasis cartoon"]
video.channel_id: UCtflVyBdtMNHyfQRY44myGw
video.channel_title: Oscar
video.category_id: 22
video.category_title: People & Blogs
video.view_count: 107238
video.like_count: 345
video.dislike_count: 59
video.favorite_count: 0
video.comment_count: 22
neutral|0.0|@u
negative|-1.1875|Oscar is so cute and funny but I hate when popy buck and harchi bully Oscar :( . Ticks me out so much
positive|0.25|Been so long since I seen dis
negative|-0.3125|I like the brown Lizard
positive|0.041700000000000015|How did the chicken get green <br />And big
neutral|0.0|stuped
neutral|0.0|ggdhshhhrrghsgccsjetcr
negative|-0.3125|I like the brown lizards and greeeeeeeen!!!
neutral|0.0|te ase reír<br />carajo<br />puta madre
neutral|0.0|I like The Crocodiles
neutral|0.0|my lil sister loves this thnx
positive|0.25|i don t like popy to
neutral|0.0|me to
neutral|0.0|me to
negative|-0.4375|I hate popy
```

So, the data is there, though one could argue the sentiment analyses on the comments using the `sentimental` [gem](https://rubygems.org/gems/sentimental) with raw data did not yield impressive result (yet)...
