# frozen_string_literal: true

desc 'Run application console (pry)'
task :console do
  sh 'pry -r ./init.rb'
end

USERNAME = 'jerry91400'
IMAGE = 'light-of-day-subscribe_worker'
VERSION = '0.1.0'

desc 'Build Docker image'
task :worker do
  require_relative './init'
  LightofdayWorker::SendLightofdayWorker.new.call
end

# Docker tasks
namespace :docker do
  desc 'Build Docker image'
  task :build do
    puts "\nBUILDING WORKER IMAGE"
    sh "docker build --force-rm -t #{USERNAME}/#{IMAGE}:#{VERSION} ."
  end

  desc 'Run the local Docker container as a worker'
  task :run do
    env = ENV['WORKER_ENV'] || 'development'

    puts "\nRUNNING WORKER WITH LOCAL CONTEXT"
    puts " Running in #{env} mode"

    sh 'docker run -e WORKER_ENV -v $(pwd)/config:/worker/config --rm -it ' \
       "#{USERNAME}/#{IMAGE}:#{VERSION}"
  end

  desc 'Remove exited containers'
  task :rm do
    sh 'docker rm -v $(docker ps -a -q -f status=exited)'
  end

  desc 'List all containers, running and exited'
  task :ps do
    sh 'docker ps -a'
  end
end

# Heroku container registry tasks
namespace :heroku do
  desc 'Build and Push Docker image to Heroku Container Registry'
  task :push do
    puts "\nBUILDING + PUSHING IMAGE TO HEROKU"
    sh 'heroku container:push worker'
  end

  desc 'Run worker on Heroku'
  task :run do
    puts "\nRUNNING CONTAINER ON HEROKU"
    sh 'heroku run rake worker'
  end
end
