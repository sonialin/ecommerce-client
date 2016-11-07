class Product
  include HTTParty
  base_uri 'http://ecs.amazonaws.com'
  default_params Service: 'AWSECommerceService', Operation: 'ItemSearch', SearchIndex: 'Books'

  def initialize(key)
    self.class.default_params AWSAccessKeyId: key
  end

  def search(options = {})
    raise ArgumentError, 'You must search for something' if options[:query].blank?

    # amazon uses nasty camelized query params
    options[:query] = options[:query].inject({}) { |h, q| h[q[0].to_s.camelize] = q[1]; h }

    # make a request and return the items (NOTE: this doesn't handle errors at this point)
    self.class.get('/onca/xml', options)['ItemSearchResponse']['Items']
  end
end