# encoding: utf-8

module Nanoc3::Extra::VCSes

  class Dummy < Nanoc3::Extra::VCS

    def add(filename)
    end

    def remove(filename)
      FileUtils.rm_rf(filename)
    end

    def move(src, dst)
      FileUtils.move(src, dst)
    end

  end

end
