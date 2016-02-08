class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    title = params[:message][:headers][:subject]
    email = params[:envelope][:sender]
    @user = User.find_by(email: email)
   @topic = Topic.find_by(title: title)
    @url = params['body-plain']


    if User.nil?
      @user = User.create!(email: email, password: 'password')
      @user.skip_confirmation!
      @user.save!
    else
      user = @user
    end

    if Topic.nil?
      @topic = Topic.create!(title: title, user: @user)
    end

    Bookmark.create!(topic: @topic, user: @user, url: @url)
    # Find the user by using params[:sender]
    # Find the topic by using params[:subject]
    # Assign the url to a variable after retreiving it from params["body-plain"]

    # Check if user is nil, if so, create and save a new user

    # Check if the topic is nil, if so, create and save a new topic

    # Now that you're sure you have a valid user and topic, build and save a new bookmark

    # Assuming all went well.
    head 200
  end


end