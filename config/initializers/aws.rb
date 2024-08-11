Aws.config.update({
  region: 'ap-northeast-1',  # SES のリージョン
  credentials: Aws::Credentials.new( ENV['AWS_ACCESS_KEY_ID'],ENV['AWS_SECRET_ACCESS_KEY'])
})