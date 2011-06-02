namespace :carrierwave do
  desc "Clean out temp CarrierWave files"
  task :clean do
    `./limpiarCW`
  end
end
