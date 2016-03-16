guard 'rspec', cmd: 'bundle exec rspec' do
  # Watch /lib/* files
  watch(%r{^lib/(.+).rb$}) do |m|
    "spec/#{m[1]}_spec.rb"
  end

  # Watch /spec/* files
  watch(%r{^spec/(.+).rb$}) do |m|
    "spec/#{m[1]}.rb"
  end
end
