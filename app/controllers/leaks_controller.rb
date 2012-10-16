class LeaksController < ApplicationController

  def index
    @hits = search_leaks
  end

  def show
    @leak = Leak.find(params[:id])
  end

  private

  def search_leaks
    return [] if params[:q].blank?

    hits = Leak.search do
      fulltext params[:q]
    end.hits
    hits.reject{ |hit| hit.result.nil? }
  end


end
