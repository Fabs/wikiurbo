class UrboController < ApplicationController

  def index
    @map = GMap.new("map_div")
               # @map.control_init(:large_map => true,:map_type => true)
    @map.center_zoom_init([0,0],1)
               # @map.overlay_init(GMarker.new([75.6,-42.467],:title => "Hello", :info_window => "Info! Info!"))
    
  end

end
