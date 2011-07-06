# EmptyImageStub is based on an idea Julian Raschke suggested in #gosu
# on IRC. It provides empty RMagic::Image-like objects which, when
# passed to Gosu::Image's constructor, have their to_blob method called,
# to provide RGBA data. This allows the easy creation of new Gosu::Image
# objects without accessing the filesystem, which can then be drawn into
# with TexPlay.
#
# http://www.libgosu.org/cgi-bin/mwf/topic_show.pl?tid=196
#
class EmptyImageStub
   def initialize(w,h)
     @w, @h = w, h;
   end

   def to_blob
     "\0" * @w * @h * 4
   end

   def rows
     @h
   end

   def columns
     @w
   end
 end
