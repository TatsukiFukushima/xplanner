class MemoController < ApplicationController
  before_action :set_memo, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  before_action :correct_user_for_memo, only: [:show, :edit, :update, :destroy]
  before_action :correct_user_for_l_memo, only: [:l_new, :l_create]
  before_action :correct_user_for_m_memo, only: [:m_new, :m_create]
  before_action :correct_user_for_s_memo, only: [:s_new, :s_create]
  before_action :correct_user_for_a_memo, only: [:a_new, :a_create]
  
  
  def l_new
    @memo = @long_term_goal.build_memo
  end
  
  def l_create
    @memo = @long_term_goal.build_memo(memo_params)
    if @memo.save 
      flash[:success] = "メモを作成しました"
      redirect_to request.referer
    else 
      render 'l_new'
    end 
  end 
  
  def m_new 
    @memo = @mid_term_goal.build_memo
  end 
  
  def m_create
    @memo = @mid_term_goal.build_memo(memo_params)
    if @memo.save 
      flash[:success] = "メモを作成しました"
      redirect_to request.referer
    else 
      render 'm_new'
    end 
  end 
  
  def s_new 
    @memo = @short_term_goal.build_memo
  end 
  
  def s_create
    @memo = @short_term_goal.build_memo(memo_params)
    if @memo.save 
      flash[:success] = "メモを作成しました"
      redirect_to request.referer
    else 
      render 's_new'
    end 
  end 
  
  def a_new
    @memo = @approach.build_memo
  end 
  
  def a_create
    @short_term_goal = @approach.short_term_goal
    @memo = @approach.build_memo(memo_params)
    if @memo.save 
      flash[:success] = "メモを作成しました"
      redirect_to request.referer
    else 
      render 'a_new'
    end 
  end 
  
  def show
  end

  def edit
  end
  
  def update #redirect_to request.urlとか良さそう　リダイレクトないでもいい
    if @memo.update_attributes(memo_params)
      flash[:success] = "メモを編集しました"
      redirect_to request.referer
    else 
      render 'edit' 
    end 
  end 

  def destroy #redirect_to request.urlとか良さそう  リダイレクトなしでもいい
    @memo.destroy 
    flash[:success] = "メモを削除しました"
    redirect_to request.referer
  end 
  
  
  private 
  
    def set_memo 
      @memo = Memo.find(params[:id])
    end
    
    def memo_params
      params.require(:memo).permit(:content)
    end 
    
    
    # beforeアクション
    
    # 正しいユーザーかどうか確認
    def correct_user_for_memo
      if @memo.memoable.class == LongTermGoal 
        @user = @memo.memoable.user
      elsif @memo.memoable.class == MidTermGoal
        @user = @memo.memoable.long_term_goal.user
      elsif @memo.memoable.class == ShortTermGoal
        @user = @memo.memoable.mid_term_goal.long_term_goal.user
      elsif @memo.memoable.class == Approach
        @user = @memo.memoable.short_term_goal.mid_term_goal.long_term_goal.user
      end 
      redirect_to(root_url) unless current_user?(@user)
    end 
    
    # その長期目標にメモをつくるユーザーとして正しいかどうかの確認
    def correct_user_for_l_memo
      @long_term_goal = LongTermGoal.find(params[:long_term_goal_id])
      @user = @long_term_goal.user 
      redirect_to(root_url) unless current_user?(@user)
    end 
    
    # その中期目標にメモをつくるユーザーとして正しいかどうかの確認
    def correct_user_for_m_memo
      @mid_term_goal = MidTermGoal.find(params[:mid_term_goal_id])
      @user = @mid_term_goal.long_term_goal.user
      redirect_to(root_url) unless current_user?(@user)
    end 
    
    # その短期目標にメモをつくるユーザーとして正しいかどうかの確認
    def correct_user_for_s_memo 
      @short_term_goal = ShortTermGoal.find(params[:short_term_goal_id])
      @user = @short_term_goal.mid_term_goal.long_term_goal.user
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # そのアプローチにメモをつくるユーザーとして正しいかどうかの確認
    def correct_user_for_a_memo 
      @approach = Approach.find(params[:approach_id])
      @user = @approach.short_term_goal.mid_term_goal.long_term_goal.user
      redirect_to(root_url) unless current_user?(@user)
    end 
end
