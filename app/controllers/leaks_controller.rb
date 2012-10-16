class LeaksController < ApplicationController

  def index
    @hits = search_leaks
  end

  def show
  end

  private

  def search_leaks
    return [] if params[:q].blank?

    Leak.search do
      fulltext params[:q]
    end.hits
  end


end
