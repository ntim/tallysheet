class WebsocketController < ApplicationController
  include Tubesock::Hijack

  def websocket
  	hijack do |tubesock|
      # Listen on its own thread
      redis_thread = Thread.new do
        # Needs its own redis connection to pub
        # and sub at the same time
        Redis.new.subscribe "active_record" do |on|
          on.message do |channel, message|
            tubesock.send_data message
          end
        end
      end
      
      tubesock.onclose do
        # stop listening when client leaves
        redis_thread.kill
      end
    end
  end

end
