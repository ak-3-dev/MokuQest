class SearchesController < ApplicationController
  def search
    @range = params[:range]
    @search_method = params[:search_method]
    @keyword = params[:keyword]

    if @keyword.blank?
      if @range == "user"
        @results = User.all
      elsif @range == "quest"
        @results = Quest.all
      end
      return
    end

    if @range == "user"
      if @search_method == "perfect"
        @results = User.where(name: @keyword) 
      elsif @search_method == "partial"
        @results = User.where("name LIKE ?", "%#{@keyword}%") 
      end
    elsif @range == "quest"
      if @search_method == "perfect"
        @results = Quest.where(title: @keyword)
      elsif @search_method == "partial"
        @results = Quest.where("title LIKE ?", "%#{@keyword}%")
      end
    end
  end
end
