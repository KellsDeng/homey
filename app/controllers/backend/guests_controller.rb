class Backend::GuestsController < ApplicationController
  layout 'backend'
  before_action :authenticate_user!
  def index
    @guests=Guest.order("status").page(params[:page]).per(20)
  end
  def show
    @guest=Guest.find(params[:id])
    if @guest.follows.any?
      @guest.follows.last.last_follow_date=Time.now() if @guest.follows.last.user_id=current_user.id
    end
  end
  def new
    @guest=Guest.new
    @guest.refer_guests.build
    @guest.follows.build
  end
  def edit
    @guest=Guest.find(params[:id])
    @guest.refer_guests.build if @guest.refer_guests.empty?
    @guest.follows.build if @guest.follows.empty?
  end
  def create
    @guest=Guest.new(guest_params)
    if @guest.save
      redirect_to backend_guests_path
    else
      render :new
    end
  end
  def update
    @guest=Guest.find(params[:id])
    # if params[:guest][:user_ids].present?
    #   binding.pry
    #   # @guest.users << User.find(params[:guest][:user_ids])
    #   @guest.follows.build(
    #     :user_id=>params[:guest][:user_ids],
    #     :name=>User.find(params[:guest][:user_ids]).email.split("@")[0],
    #     :last_follow_date=>Time.now().strftime('%F %H:%M')
    #   )
    #
    # end
    if @guest.update(guest_params)
      redirect_to backend_guests_path
    else
      render :edit
    end
  end
  def destroy
    @guest=Guest.find(params[:id])
    @guest.destroy
    flash[:alert]="已删除此条信息!"
    redirect_to backend_guests_path
  end

  private
  def guest_params
    params.require(:guest).permit(:name,:country_code,:status,:job,:email,:wechat,:phone,:company,:referrer,:approach,:house_district,:house_type,:liked_estate,:landscape,:house_floor,:house_parking,:house_furnished,:house_XIS,:check_in_date,:duration,:budget,:has_pet,:want_buy,:other_requests,:follows_attributes=>[:id,:user_id,:guest_id,:name,:last_follow_date,:memo,:_destroy],:option_ids=>[],:refer_guests_attributes=>[:id,:name,:contact,:_destroy])
  end
end
