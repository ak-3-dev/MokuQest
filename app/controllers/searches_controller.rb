class SearchesController < ApplicationController
  def search
    if params[:range] == "user"
     if params[:search_method] == "perfect"
        @results = User.where(name: params[:keyword]) 
      elsif params[:search_method] == "partial"
        @results = User.where("name LIKE ?", "%#{params[:keyword]}%") 
      end
    elsif params[:range] == "quest"
      if params[:search_method] == "perfect"
        @results = Quest.where(title: params[:keyword])
      elsif params[:search_method] == "partial"
        @results =Quest.where("title LIKE ?", "%#{params[:keyword]}%")
      end
    end
  end
end
