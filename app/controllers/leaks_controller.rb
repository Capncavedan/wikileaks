class LeaksController < ApplicationController

  def index
    do_search
  end

  def show
  end

  private

  def do_search
    @hits = []
    return if params[:q].blank?
    @hits = Leak.search do
      fulltext params[:q]
    end.hits
  end

end
