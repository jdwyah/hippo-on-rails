class TopicsController < ApplicationController
  before_filter :require_user
  before_filter :find_topic, :only => [:show, :edit, :update]
  
  def new
    @topic = Topic.new
  end
  
  def create
    @topic = Topic.new(params[:topic])
  end
  
  def show
    
  end
  
  def edit
    
  end

  def update
    if @topic.update_attributes(params[:topic])
      flash[:notice] = "Topic updated!"
      redirect_to topics_url
    else
      render :action => :edit
    end
  end
  
  protected
  
    def find_topic
      @topic = Topic.find(params[:id])
    end

end
