class Classroom < ApplicationRecord
    enum building_name: [:A동, :B동, :C동, :D동, :E동, :F동,
                            :I동, :K동, :L동, :P동, :Q동, :R동, :T동 ]
end
