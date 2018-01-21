class ImagesController < ApplicationController
  # replaced by ln -s /data/ data
  def serve
    path = "#{params[:filename]}"
    send_file( path,
      :disposition => 'inline',
      :type => 'image/jpeg',
      :x_sendfile => true )
  end
end