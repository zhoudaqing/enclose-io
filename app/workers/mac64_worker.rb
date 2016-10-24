class Mac64Worker
  include Sidekiq::Worker
  sidekiq_options queue: 'mac64'

  def perform(id)
    Executable.find(id).compile!
  end
end
