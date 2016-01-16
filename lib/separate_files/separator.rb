require 'fileutils'

module SeparateFiles
  class Separator

    attr_accessor :source_dir, :destination_dir, :extensions

    def initialize(source_dir, destination_dir, extensions)
      @source_dir = ensure_slash_at_end source_dir
      @destination_dir = ensure_slash_at_end destination_dir
      @extensions = extensions
    end

    def separate!
      files = source_files(source_dir, extensions)
      move_files(files, source_dir, destination_dir)
    end

    def move_files(files, source_dir, destination_dir)
      files.each do |f|
        src = source_dir + f
        dst = destination_dir + f
        move_file src, dst
      end
    end

    def move_file(src, dst)
      puts "#{src} -> #{dst}"
      dst_dir = dst.split('/')[0..-2].join('/')
      FileUtils.mkdir_p dst_dir
      FileUtils.move src, dst

    end


    def source_files(source_dir, extensions)
      current_dir = Dir.pwd
      Dir.chdir source_dir

      files = Dir.glob("**/*.{#{extensions}}").select{|f| File.file? f}

      # Dir.glob("#{source_dir}/**/*")

      Dir.chdir current_dir
      files
    end


    private
    def ensure_slash_at_end(str)
      if str.end_with?('/')
        str
      else
        str+'/'
      end

    end

  end
end
