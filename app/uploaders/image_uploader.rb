class ImageUploader < CarrierWave::Uploader::Base

	include Cloudinary::CarrierWave

	# Generate a 164x164 JPG of 80% quality 
	process :resize_to_fill => [320, 320, :north]
	process :convert => 'jpg'
	cloudinary_transformation :quality =>  50


end
