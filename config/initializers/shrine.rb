if Rails.env.production?
  require 'shrine/storage/s3'
  Shrine.storages = {
      cache: Shrine::Storage::S3.new(
          access_key_id:     ENV['S3_ACCESS_KEY_ID'],
          secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
          region:            'us-east-1',
          bucket:            'group-chat-jakehockey10',
          prefix:            'cache'
      ),
      store: Shrine::Storage::S3.new(
          access_key_id:     ENV['S3_ACCESS_KEY_ID'],
          secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
          region:            'us-east-1',
          bucket:            'group-chat-jakehockey10',
          prefix:            'store'
      )
  }
else
  require 'shrine/storage/file_system'
  Shrine.storages = {
      cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'),
      store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/store')
  }
end

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for forms
Shrine.plugin :determine_mime_type