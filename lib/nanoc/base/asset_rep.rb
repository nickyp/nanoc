module Nanoc

  class AssetRep < Nanoc::ItemRep

    # For compatibility
    alias_method :asset, :item

    # Returns the type of this object.
    def type
      :asset_rep
    end

    # Returns the path to the output file as it would be used in a web
    # browser: starting with a slash (representing the web root), and only
    # including the filename and extension if they cannot be ignored (i.e.
    # they are not in the site configuration's list of index files).
    def web_path
      Nanoc::NotificationCenter.post(:visit_started, self)
      Nanoc::NotificationCenter.post(:visit_ended,   self)

      @item.site.compiler.compile_rep(self, false)

      @web_path ||= @item.site.router.web_path_for(self)
    end

  end

end
