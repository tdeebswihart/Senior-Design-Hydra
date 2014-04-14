# require 'ActiveFedora'
require 'fileutils'
# Some reference points for a more complicated representation of a file:
# - https://github.com/projecthydra/sufia/blob/master/sufia-models/lib/sufia/models/generic_file.rb
# - https://github.com/projecthydra/sufia/blob/master/lib/sufia/files_controller/local_ingest_behavior.rb
#
#
class GenericFile # < ActiveFedora::Base

	attr_accessor :name, :data_file_path

	# note: the filename passed in must be either an absolute path or a proper relative path
	def new(filename)
		self.name = File.basename(filename)

		storage_path = File.join(Dir.pwd, 'files')
		new_path = File.join(storage_path, filename)

		if File.exists?(new_path)
	    	# for now do nothing
	    	puts "File #{new_path} already exists!"
	    	self.data_file_path = nil
	    else
	    	FileUtils.mv(filename, new_path)
	    	self.data_file_path = new_path
	    end
	end

	# def ingest_local_file(filename)
 #    # Ingest files already on disk
 #    # trivial example that will only work
 #    storage_path = File.join(Dir.pwd, 'files')
 #    new_path = File.join(storage_path, filename)

 #    if File.exists?(new_path)
 #    	# for now do nothing
 #    	puts "File #{new_path} already exists!"
 #    	false
 #    else
 #    	FileUtils.mv(filename, new_path)
 #    	self.data_file_path = new_path
 #    	true
 #    end
end

	# def ingest_one(filename, unarranged)
 #    # do not remove ::
 #    @generic_file = ::GenericFile.new
 #    basename = File.basename(filename)
 #    @generic_file.label = basename
 #    @generic_file.relative_path = filename if filename != basename
 #    create_metadata(@generic_file)
 #    Sufia.queue.push(IngestLocalFileJob.new(@generic_file.id, current_user.directory, filename, current_user.user_key))
 #  end
