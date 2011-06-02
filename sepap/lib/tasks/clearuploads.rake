namespace :carrierwave do
  desc "Clean out temp CarrierWave files"
  task :clean do
    puts CarrierWave.clean_cached_files! 
     end
end
