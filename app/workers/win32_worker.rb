class Win32Worker
  include Sidekiq::Worker
  sidekiq_options queue: 'win32'

  def perform(id)
    Executable.find(id).compile!
  end
end
