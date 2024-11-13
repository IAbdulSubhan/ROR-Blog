class TestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Yeh code background mein run ho ga
    puts "Background job is running with args: #{args}"
  end
end
