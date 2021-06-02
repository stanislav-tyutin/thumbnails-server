# Simple thumbnails server

## Setup

### Ruby version
Ruby 2.7.1

### Gem installation
`bundle install`

### ENVs
`PUBLIC_DIR=/tmp/public` - absolute path to public directory (must be writeable)

`PUBLIC_URL=https://example.com/public` - url to public directory

`PUMA_THREADS=5`

`PUMA_PORT=9292`

`PUMA_WORKERS=1`

### Database and migrations
None

### External dependencies
`ffmpeg`

## Run
`bundle exec puma`
