#!/usr/local/bin/ruby

require "logger"

logger = Logger.new(STDOUT)
logger.level = Logger::INFO

def package
  <<~HEREDOC
    sam package --template-file template.yaml \
    --output-template-file packaged-template.yaml \
    --s3-bucket stocks-lambda.rickpeyton.com
  HEREDOC
end

def deploy
  <<~HEREDOC
    sam deploy --template-file packaged-template.yaml \
    --stack-name stocks-lambda \
    --capabilities CAPABILITY_IAM
  HEREDOC
end

logger.info `#{package}`
logger.info `#{deploy}`
