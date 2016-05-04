class GameSessionsController < ApplicationController

  def show
    get_game
  end

  def new
    @game = GameSession.new
  end

  def create
    @game = current_user.game_sessions.build(game_params)
    if @game.save
      respond_to do |format|
        format.html do
          binding.pry
          redirect_to game_session_path
        end
        format.json do
          render json: { message: "Game created!", game_id: @game.id }
        end
      end
    end
  end

  private
  def get_game
    @game = GameSession.find(params.fetch(:id))
  end

  def game_params
    params.require(:game_session).permit(:session_name, :user_id)
  end
end
