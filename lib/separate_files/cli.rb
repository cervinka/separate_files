require 'main'
require_relative '../separate_files.rb'

module SeparateFiles
  class CLI
    def self.start(argv)
      Main {
        argument 'source_dir'
        argument 'destination_dir'
        argument 'extensions'

        def run
          if param['source_dir'].given? && params['destination_dir'].given? && params['extensions'].given?
            source_dir = params['source_dir'].value
            destination_dir = params['destination_dir'].value
            extensions = params['extensions'].value
            SeparateFiles::Separator.new(source_dir, destination_dir, extensions).separate!
            exit_success!
          else
            help!
          end

        end
      }


    end
  end
end
