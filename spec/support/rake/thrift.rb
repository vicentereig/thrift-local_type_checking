namespace :spec do
  namespace :thrift do
    desc 'Generate Thrift client and service files'
    task :generate do
      sh 'bundle exec thrift --out spec/support/thrift --gen rb spec/support/accounts.thrift'
    end
  end
end
