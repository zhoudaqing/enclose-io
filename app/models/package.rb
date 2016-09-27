class Package < ApplicationRecord
  belongs_to :project
  KINDS = {
    'exe32' => 'x86.exe',
    'msi32' => 'x86.msi',
    'linux64' => 'linux-x64',
    'mac64' => 'darwin-x64'
  }
  enum kind: KINDS.keys
  enum phase: ['doing', 'done']

  def suffix
    KINDS[kind]
  end
  
  def filename
    "#{name}-#{version}-#{suffix}"
  end
end
