require 'aws-sdk-s3'
require 'yaml'

raise 'deploy/aws_credentials.yml not found' unless File.exist?('./deploy/aws_credentials.yml')

aws_credentials = YAML.load(File.read('./deploy/aws_credentials.yml'))
access_key_id = aws_credentials['access_key_id']
secret_access_key = aws_credentials['secret_access_key']

Aws.config.update(
  { credentials: Aws::Credentials.new(access_key_id, secret_access_key) }
)

client = Aws::S3::Client.new(region: 'us-east-1')
s3 = Aws::S3::Resource.new(region: 'us-east-1')

bucket_name = 'cannabiscompetitor.info'
bucket = s3.bucket(bucket_name)

# delete existing
bucket.objects.each do |obj|
  obj.delete
end

# upload new
s3.bucket(bucket_name).put_object(key: "assets/images/")

files_for_images_directory = Dir.glob("assets/images/**/*")
files_for_images_directory.each do |file|
  obj = s3.bucket(bucket_name).object(file)
  obj.upload_file(file)
end

files_for_css_directory = Dir.glob("assets/css/**/*")
files_for_css_directory.each do |file|
  obj = s3.bucket(bucket_name).object(file)
  obj.upload_file(file)
end

files = ['index.html', 'Contact.html', 'javascript.js']
files.each do |file|
  name = File.basename(file)
  obj = s3.bucket(bucket_name).object(name)
  obj.upload_file(file)
end