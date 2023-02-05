require './lib/core'
require './lib/fs'
require './lib/hash'

ENV.instance_eval do
  extend TrapdoorCore
end
