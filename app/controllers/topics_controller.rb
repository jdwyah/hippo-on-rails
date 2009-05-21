class TopicsController < ApplicationController
  before_filter :require_user
  
  def new
    @topic = Topic.new
  end
  
  def create
    @topic = Topic.new(params[:topic])
  end
  
  def show
    @topic = Topic.find(params[:id])
  end
  
  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(params[:topic])
      flash[:notice] = "Topic updated!"
      redirect_to topics_url
    else
      render :action => :edit
    end
  end

end
