class Url < ApplicationRecord
	before_create :shorten #before i save go do shorten 
	validates :long_url, presence: { message: "is required! " }, format: { :with => URI::regexp(%w(http https)) }
    validates :long_url, uniqueness: true


	after_validation :smart_add_url_protocol

	def shorten
      self.short_url = [*('a'..'z'),*('0'..'9')].shuffle[0,7].join
	end

	protected

	def smart_add_url_protocol
 	  unless self.long_url[/\Ahttp:\/\//] || self.long_url[/\Ahttps:\/\//]
   	    self.long_url = "http://#{self.long_url}"
 	  end
	end

end
