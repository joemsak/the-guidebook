class Admin::CoachesController < AdminController
  before_action :authenticated_admin!
  before_action :set_coach, only: %i[ show edit update destroy ]

  def index
    @coaches = User.joins(:coach_profile).all
  end

  def new
    @coach = User.new
  end

  def create
    @coach = User.new(coach_params)

    respond_to do |format|
      if @coach.save
        @coach.create_coach_profile!

        format.html {
          redirect_to admin_coach_path(@coach), notice: t('.success')
        }

        format.json {
          render :show, status: :created, location: @coach
        }
      else
        format.html {
          render :new, status: :unprocessable_entity
        }

        format.json {
          render json: @coach.errors, status: :unprocessable_entity
        }
      end
    end
  end

  def update
    respond_to do |format|
      if @coach.update(coach_params)
        format.html {
          redirect_to admin_coach_path(@coach), notice: t('.success')
        }

        format.json {
          render :show, status: :ok, location: @coach
        }
      else
        format.html {
          render :edit, status: :unprocessable_entity
        }

        format.json {
          render json: @coach.errors, status: :unprocessable_entity
        }
      end
    end
  end

  def destroy
    @coach.destroy
    respond_to do |format|
      format.html {
        redirect_to admin_coaches_url,
          notice: "Coach was successfully destroyed."
      }

      format.json { head :no_content }
    end
  end

  private
  def set_coach
    @coach = User.friendly.find(params[:id])
  end

  def coach_params
    params.require(:coach)
      .permit(:name, :email, :password, :password_confirmation)
  end
end
