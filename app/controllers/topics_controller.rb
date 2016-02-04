class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      flash[:notice]= "Topic was saved."
      redirect_to @topic
    else
      flash.now[:alert]= "The topic could not be saved. Please try again"
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.assign_attributes(topic_params)

    if @topic.save
      flash[:notice]= "The topic was saved sucessfully."
      redirect_to @topic
    else
      flash.now[:alert]= "There was an error saving the topic. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      flash[:notice]= "\"#{@topic.title}\" was deleted successfully."
      redirect_to topics_path
    else
      flash.now[:alert] = "There was an error in deleting this topic."
      render :show
    end
  end

  def topic_params
    params.require(:topic).permit(:title)
  end
end
