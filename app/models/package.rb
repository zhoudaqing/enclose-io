class Package < ApplicationRecord
  belongs_to :project
  after_create :enqueue
  mount_uploader :file, AttachmentUploader

  KINDS = {
    'exe32' => 'x86.exe',
    'linux64' => 'x64-linux',
    'mac64' => 'x64-darwin'
  }
  enum kind: KINDS.keys
  enum phase: ['pending', 'doing', 'done']

  def suffix
    KINDS[kind]
  end

  def filename
    "#{name}-#{version}-#{suffix}"
  end
  
  def enqueue
    CompilerWorker.perform_async(id)
    true
  end
end
