require 'shrine/storage/s3'

s3_options = {
    access_key_id:     ENV['S3_ACCESS_KEY_ID'],
    secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
    region:            ENV['S3_REGION'],
    bucket:            ENV['S3_BUCKET']
}

Shrine.storages = {
    cache: Shrine::Storage::S3.new(
        prefix:         'cache',
        upload_options: { acl: 'public-read' },
        **s3_options
    ),
    store: Shrine::Storage::S3.new(
        prefix: 'store',
        upload_options: { acl: 'public-read' },
        **s3_options
    )
}

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for forms
Shrine.plugin :direct_upload
Shrine.plugin :restore_cached_data
Shrine.plugin :determine_mime_type