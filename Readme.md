Barebones framework for ruby using ActiveRecords with Sinatra for backend

1. create rake db:create_migration NAME="name migration file here"
2. edit newly created migration file
3. rake db:migrate
4. create controllers and models with ActiveRecord associations (has_many :name || has_many :name, through: :name2 || belongs_to :name)
5. in config.ru add your controllers below 
run ApplicationController
use NewControllersName
