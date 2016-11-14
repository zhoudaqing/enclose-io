require 'fileutils'

class Executable < ApplicationRecord
  belongs_to :project
  before_save :calculate_size
  after_create :enqueue
  mount_uploader :file, AttachmentUploader

  KINDS = {
    'win64' => 'x64.zip',
    'linux64' => 'linux-x64.gz',
    'mac64' => 'darwin-x64.gz'
  }
  enum kind: KINDS.keys
  enum phase: ['pending', 'doing', 'done']

  def self.zip!(filename_path)
    raise 'filename_path should end with .zip' unless filename_path.ends_with?('.zip')
    filename_path0 = filename_path[0..-5]
    FileUtils.mv(filename_path, filename_path0)
    raise '.zip file path should now not exist' unless !File.exist?(filename_path)
    `7z -tzip a #{Shellwords.escape filename_path} #{Shellwords.escape filename_path0}`
    raise '.zip file path should now exist' unless File.exist?(filename_path)
  end

  def self.gzip!(filename_path)
    raise 'filename_path should end with .gz' unless filename_path.ends_with?('.gz')
    filename_path0 = filename_path[0..-4]
    FileUtils.mv(filename_path, filename_path0)
    raise '.gz file path should now not exist' unless !File.exist?(filename_path)
    `gzip #{Shellwords.escape filename_path0}`
    raise '.gz file path should now exist' unless File.exist?(filename_path)
  end

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
    filename_path = File.expand_path("./#{filename}", Dir.tmpdir)
    STDERR.puts "Compiling #{id}: #{attributes} => #{filename_path}"

    update_attribute(:phase, 'doing')
    argv = [node_version, project.name, version, name, filename_path]
    instance = ::Enclose::IO::Compiler.new *argv
    instance.run!

    case kind
    when 'win64'
      self.class.zip!(filename_path)
    when 'linux64', 'mac64'
      self.class.gzip!(filename_path)
    else
      raise "Unexpected kind #{kind}"
    end

    self.file = File.open(filename_path, 'r')
    self.phase = :done
    self.done_at = Time.now
    save!
  end
end
