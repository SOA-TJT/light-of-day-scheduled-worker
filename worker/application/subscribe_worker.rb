# frozen_string_literal: true

require_relative '../../init.rb'
require 'aws-sdk-ses'

module LightofdayWorker
  # Scheduled worker to send light of day to subscriber
  class SendLightofdayWorker
    def initialize
      @config = SendLightofdayWorker.config
      puts @config.SUBSCRIBE_QUEUE_URL
      @queue = LightofDay::Messaging::Queue.new(
        @config.SUBSCRIBE_QUEUE_URL, @config
      )
    end

    def call
      puts "REPORT DateTime: #{Time.now}"
      @queue.send({ 'action' => 'send' }.to_json)
    end
  end
end
