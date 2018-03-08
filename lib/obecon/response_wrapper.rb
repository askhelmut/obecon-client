# frozen_string_literal: true

module Obecon
  class ResponseWrapper
    RESULT = "result"
    ASSET = "asset"
    # SLOTS
    # Fotostrecke
    # Szenenbilder
    # BB*=459x400, jpg, rgb
    GALLERY = "fotostrecke"

    # Filmplakat
    # Filmplakat
    # BB*=400x10000, jpg, rgb
    POSTER = "filmplakat"

    # Filmbild
    # teaser Image klein
    # BB*=180x10000, jpg, rgb
    TEASER_SMALL = "filmbild"

    # Splash
    # teaser Image gross
    # BB*=456x340, jpg, rgb
    TEASER_LARGE = "splash"

    # webcontainer
    # Event Content
    # BB*=456x340, jpg, rgb
    WEBCONTAINER = "webcontainer"

    # *(_hq)
    # Flash-Video
    # 456x340, 480kbit Video, flv
    VIDEO_HQ = "video_hq"

    # *(_small_hq)
    # Flash-Video
    # 180x132, 192kBit Video, flv
    VIDEO_SMALL_HQ = "video_small_hq"

    # *(_small_lq)
    # Flash-Video
    # 180x132, 64kBit Video, flv
    VIDEO_SMALL_LQ = "video_small_lq"

    # mp4
    # H264 Video
    # BB*=640x512, 830kBit Video, h264
    VIDEO_MP4 = "video_mp4"

    attr_reader :response
    def initialize(response = nil)
      assets = JSON.parse(response)[RESULT][ASSET]
      @slot_map = map_by_slots(assets)
    end

    def method_missing(method_name, *_args)
      mapped_slot = ResponseWrapper.const_get method_name.upcase
      @slot_map[mapped_slot.to_sym]
    end

    private

    def map_by_slots(array)
      result = {}
      array.each do |entry|
        key = entry["slot"].to_sym
        result[key] = [] unless result.key?(key)
        result[key] << Obecon::Asset.new(entry)
      end
      result
    end
  end
end
