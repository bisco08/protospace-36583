class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototypes = Prototype.create(prototype_params)
    if  @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comment.includes(:user)
  end

  def edit
    @prototypes = Prototype.find(params[:id])
    unless current_user
      redirect_to action: :index
    end
  end

  def update
    @prototypes = Prototype.find(params[:id])
    if @prototypes.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end


  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

end
