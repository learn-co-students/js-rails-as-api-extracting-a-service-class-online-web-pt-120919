class SightingsController < ApplicationController
    def index
      sightings = Sighting.all
      render json: SightingSerializer.new(sightings).to_serialized_json
    end
   
    def show
      sighting = Sighting.find_by(id: params[:id])
      render json: SightingSerializer.new(sighting).to_serialized_json
    end
  end
#   Extraction complete! We've resolved the issue of keeping our controller clear of excess logic by moving it to a separate class. However, we still haven't made our to_json any easier to read.
  
#   Organizing Options
#   In the to_serialized_json method, we are passing multiple options into to_json when it is called. These options are just key/value pairs in a hash, though, and we can choose to break this line up to get a better grasp of what is actually going on. Rewriting the method without changing any functionality, we could write:
  
  def to_serialized_json
    options = {
      include: {
        bird: {
          only: [:name, :species]
        },
        location: {
          only: [:latitude, :longitude]
        }
      },
      except: [:updated_at],
    }
    @sighting.to_json(options)
  end
