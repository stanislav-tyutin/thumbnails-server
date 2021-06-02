require 'restclient'

module Logic
  class << self

    def download_video(url)
      f = Tempfile.new(['download', 'mp4'])

      resp = RestClient.get(url)
      f.write(resp.body)

      f
    ensure
      f.close
    end

    def build_thumbnails(video_file, output_path)
      command = "ffmpeg -i #{video_file.path} -r 1 -vf scale=64:-1 #{output_path}/frame_%04d.jpg"
      Kernel.system(command)
    end

  end
end
