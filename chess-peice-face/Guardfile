guard :test do
  watch(%r{^test/.+_test\.rb$})
  

  # Non-rails
  watch(%r{(.+)\.rb$}) { |m| "test/#{m[1]}_test.rb" }
end

