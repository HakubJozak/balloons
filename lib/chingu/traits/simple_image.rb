module Chingu
  module Traits
    module SimpleImage

      module ClassMethods
        def initialize_trait(options = {})
          trait_options[:simple_image] = options
        end
      end
      
      attr_accessor :x, :y, :angle, :factor_x, :factor_y, :center_x, :center_y, :zorder, :mode
      
      DEFAULTS = {
        :x => 0, :y => 0, :angle => 0,
        :factor_x => 1.0, :factor_y => 1.0,
        :zorder => 100, :center_x => 0.5, :center_y => 0.5,
        :mode => :default
      }

      def setup_trait(object_options = {})
        options = DEFAULTS.merge(trait_options[:simple_image]).merge(object_options)
        DEFAULTS.merge(options).each do |attr,value|
          self.send("#{attr}=", value)
        end
        
        self.image = options[:image]
        self.color = options[:color]
        super
      end

      def color=(color)
        if color.is_a?(Gosu::Color)
          @color = color
        else
          @color = Gosu::Color.new(color || 0xFFFFFFFF)
        end        
      end

      def image=(image)
        case image
        when Gosu::Image
          @image = image
        when String
          begin
            # 1) Try loading the image the normal way
            @image = Gosu::Image.new($window, image)
          rescue
            # 2) Try looking up the picture using Chingus Image-cache
            @image = Gosu::Image[image]
          end
        else
          puts "No image set for #{self.to_s}"
          # TODO - create placeholder visible for player/developer
        end
      end
      
      def draw_relative(x=0, y=0, zorder=0, angle=0, center_x=0, center_y=0, factor_x=0, factor_y=0)
        @image.draw_rot(@x+x, @y+y, @zorder+zorder, @angle+angle, @center_x+center_x, @center_y+center_y, @factor_x+factor_x, @factor_y+factor_y, @color, @mode) if @visible
      end
      
      def draw_at(x, y)
        draw_relative(x,y)
      end
    end
  end
end
