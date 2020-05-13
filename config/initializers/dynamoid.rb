require 'dynamoid'

Dynamoid.configure do |config|
  config.namespace = 'walkers'
end

Dynamoid.included_models.each { |m| m.create_table(sync: true) }

