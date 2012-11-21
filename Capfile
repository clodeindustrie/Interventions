load 'config/deploy' # this is your actual deploy.rb # it uses all that stuff in the gem's deploy.rb


  task :push do
    puts 'Set to production config'
    puts `sed -i 's/:development/:production/g' config.ru`
    puts 'let git that'
    puts `git add .`
    puts `git commit -m 'encore'`
    puts 'Deploying site to Heroku ...'
    puts `git push heroku`
    puts 'Back to dev config'
    puts `sed -i 's/:production/:development/g' config.ru`
  end
