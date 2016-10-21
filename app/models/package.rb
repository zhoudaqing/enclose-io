class Package < ApplicationRecord
  belongs_to :project
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
end
