CarrierWave.configure do |config|
  # TODO manual delete
  config.delete_tmp_file_after_storage = false
  config.storage    = :aws
  config.aws_bucket = ENV.fetch('S3_BUCKET_NAME')
  config.aws_acl    = 'public-read'
  config.asset_host = 'http://www.enclose.io'
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7
  config.aws_attributes = {
    expires: 1.week.from_now.httpdate,
    cache_control: 'max-age=604800'
  }
  config.aws_credentials = {
    access_key_id:     ENV.fetch('AWSAccessKeyId'),
    secret_access_key: ENV.fetch('AWSSecretKey'),
    region:            ENV.fetch('AWS_REGION') # Required
  }
end
