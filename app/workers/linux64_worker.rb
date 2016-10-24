class Linux64Worker
  include Sidekiq::Worker
  sidekiq_options queue: 'linux64'

  def perform(id)
    Executable.find(id).compile!
  end
end
