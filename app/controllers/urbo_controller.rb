class UrboController < ApplicationController

  def index
    @map = GMap.new("map_div")
    @map.center_zoom_init([0,0],1)
  end

end
