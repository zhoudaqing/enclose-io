class AttachmentUploader < CarrierWave::Uploader::Base
  storage :aws

  def store_dir
    model.project.name
  end
end

