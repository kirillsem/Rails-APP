class AudiouploadController < ApplicationController
  skip_before_action :verify_authenticity_token
  def extupload
    #@upload = Upload.new
    require 'base64'
    data=params[:mp3]
    audio_data=Base64.decode64(data['data:audio/mp3;base64,'.length .. -1])
    save_path = Rails.root.join("public/audio")
    unless File.exists?(save_path)
      Dir::mkdir(save_path)
    end
    @time = Time.now
    File.open(save_path+"_audio.mp3", 'wb') do |f| f.write audio_data end
    #current_user.user_detail.audio=File.open(save_path+"_audio.mp3")
    #current_user.user_detail.audio_content_type="application/octet-stream" 
    #begin
     # file = File.open(save_path+"1.txt", "w")
      #file.write(params)
    #rescue IOError => e
     # #some error occur, dir not writable etc.
    #ensure
     # file.close unless file.nil?
    #end
  end
end
  
