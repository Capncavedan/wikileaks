class CablesController < ApplicationController

  def index
    @hits = search_cables
  end

  def show
    @cable = Cable.find(params[:id])
  end

  private

  def search_cables
    return [] if params[:q].blank?

    search = Cable.search do
      fulltext params[:q]

      with :origin_description, params[:origin] if params[:origin].present?

      with :cable_year, params[:year] if params[:year].present?
    end
    
    search.hits.reject{ |hit| hit.result.nil? }
  end

end