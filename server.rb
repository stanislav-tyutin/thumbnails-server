require 'sinatra'
require 'digest'
require 'json'
require './logic'

get '/' do
  'Thumbnails server'
end

post '/' do
  content_type 'application/json'

  video_url = request.body.read
  video_hash = Digest::MD5.hexdigest(video_url)
  thumbnails_path = File.join(ENV.fetch('PUBLIC_DIR'), video_hash)

  unless File.exists?(thumbnails_path)
    FileUtils.mkdir_p(thumbnails_path)
    video_file = Logic.download_video(video_url)
    Logic.build_thumbnails(video_file, thumbnails_path)
    video_file.unlink
  end

  files = Dir.entries(thumbnails_path).select { |t| File.file?(File.join(thumbnails_path, t)) }
  response =
    {
      thumbnails: files.sort.map { |t| [ENV.fetch('PUBLIC_URL'), video_hash, t].join('/') }
    }
  response.to_json
end
