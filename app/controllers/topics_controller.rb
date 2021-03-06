class TopicsController < ApplicationController
  add_crumb("Topics") { |instance| instance.send :topics_path }

  before_filter :require_user
  before_filter :find_topic, :only => [:show, :edit, :update]
  before_filter :crumb_me, :only => [:show, :edit, :update]

  protect_from_forgery :only => [:create, :update, :destroy]
  
  def tag_auto_complete
    @topics = current_user.topics.find(:all, :conditions => ['name like ?', "#{params[:tags_name]}%"])
    render :layout => false
  end

  def index
    @topics = current_user.topics
  end
  
  def new
    @topic = Topic.new
    if params[:tag_id]
      @tag = Topic.find(params[:tag_id])
      @topic.tags << @tag
      @topic.setup_properties
    end
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
    @topic = current_user.topics.find(params[:id])
  end
  
  def crumb_me
    add_crumb @topic.name, @topic
  end
end
