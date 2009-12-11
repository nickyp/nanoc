# encoding: utf-8

module Nanoc3::CLI::Commands

  class Clean < Cri::Command
    require 'fileutils'
    
    def name
      'clean'
    end

    def aliases
      []
    end

    def short_desc
      'destroys the output_dir (and contents)'
    end

    def long_desc
      short_desc
    end

    def usage
      "nanoc3 clean"
    end

    def option_definitions
      []
    end

    def run(options, arguments)
      # Make sure we are in a nanoc site directory
      puts "Loading site ..."
      @base.require_site
      output_dir = @base.site.config[:output_dir]
      
      time_before = Time.now
      
      if File.exists?(output_dir)
        FileUtils.rm_r output_dir
        puts "Destroyed output_dir: '#{output_dir}' in #{format('%.2f', Time.now - time_before)}s"
      else
        puts "Can't clean non-existing output_dir: #{output_dir}"
      end
    end

  end

end
