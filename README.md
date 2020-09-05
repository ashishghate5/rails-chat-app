# Rails chat application

It's an simple Rails application for one to one chatting. Here user can friends list and select one of the friend and can start chat with them.

* Sign-up: To sign-up with appropriate fields mentioned in the form.

* Sign-in: Sign-in with email & password

* Home-Page: All stuff regarding the app, like: Showing friends-list, logout option and message body with predefined text, We also the functionality to search for a specific friend and after clicking on that friend chat body will get open for that particular chat.

* Chat-page: To chat with a specific friend.


Setup and configuration:

1. Install Ruby-2.6.2
2. Install Rails-5.2.3
3. Run "bundle install" in the project directory.
4. Setup the databse.yml file, Using Postgres, So we need to replace username & password.
 Run the following commands to create the DB and tables
 - project-dir$ rake db:create
 - project-dir$ rake db:migrate

 Live Demo: https://railschat-app.herokuapp.com/