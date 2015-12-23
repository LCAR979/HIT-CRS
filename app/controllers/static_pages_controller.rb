class StaticPagesController < ApplicationController
  layout "scroll"
  def index   
  end
  def help
  end
  def about
  end
  def feature
  end
  def signup
    render :layout => "form"
  end
end
