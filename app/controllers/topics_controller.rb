class TopicsController < ApplicationController
  before_filter :require_user
  before_filter :find_topic, :only => [:show, :edit, :update]
  
  def index
    @topics = current_user.topics
  end
  
  def new
    @topic = Topic.new
    @topic.property_types.build
  end
  
  def create
    @topic = current_user.topics.build(params[:topic])
    
    if @topic.save
      flash[:notice] = "Topic created!"
      redirect_to topic_url(@topic)
    else
      render :action => :new
    end
  end

  def update
    if @topic.update_attributes(params[:topic])
      flash[:notice] = "Topic updated!"
      redirect_to topic_url(@topic)
    else
      render :action => :edit
    end
  end
  
  protected
  
    def find_topic
      @topic = Topic.find(params[:id])
    end

end
