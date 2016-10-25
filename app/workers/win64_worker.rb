class Win64Worker
  include Sidekiq::Worker
  sidekiq_options queue: 'win64'

  def perform(id)
    Executable.find(id).compile!
  end
end
