class Executable < ApplicationRecord
  belongs_to :project
  before_save :calculate_size
  after_create :enqueue
  mount_uploader :file, AttachmentUploader

  KINDS = {
    'win32' => 'x86.exe',
    'linux64' => 'linux-x64.gz',
    'mac64' => 'darwin-x64.gz'
  }
  enum kind: KINDS.keys
  enum phase: ['pending', 'doing', 'done']

  def self.create_for!(project, name, version)
    h = { project_id: project.id, name: name, version: version }
    kinds.each do |k, _|
      ::Enclose::IO::Compiler.node_versions.each do |n|
        find_or_create_by!(h.merge(kind: k, node_version: n))
      end
    end
  end

  def suffix
    "#{node_version}-#{KINDS[kind]}"
  end

  def filename
    "#{name}-#{version}-#{suffix}"
  end

  def calculate_size
    if file.present? && file_changed?
      self.file_size = file.size
    end
    true
  end
  
  def enqueue
    "#{kind}_worker".camelize.safe_constantize.perform_async(id)
    true
  end

  def compile!
    STDERR.puts "Compiling #{id}: #{attributes}"
    update_attribute(:phase, 'doing')
    argv = [node_version, project.name, version, name]
    instance = ::Enclose::IO::Compiler.new argv, filename
    instance.run!
    self.file = File.open(instance.filename_path, 'r')
    self.phase = :done
    self.done_at = Time.now
    save!
  end
end
