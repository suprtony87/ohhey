class MissedConnectionsController < ApplicationController
  before_action :authenticate_user!, :except => [:index]

  def index
    @missed_connections = MissedConnection.all.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @missed_connection = MissedConnection.find(params[:id])
  end

  def new
    @missed_connection = MissedConnection.new()
  end

  def create
    @missed_connection = MissedConnection.new(missed_connection_params.merge(user_id: current_user.id))

    if @missed_connection.save
      redirect_to root_path, notice: 'Saved!'
    else
      flash.now[:alert] = 'Could not find that location. Please try again'
      render :new
    end
  end

  private

  def missed_connection_params
    params.require(:missed_connection).permit(:user_id, :title, :body, :latitude, :longitude, :location, :question, :answer)
  end
end
