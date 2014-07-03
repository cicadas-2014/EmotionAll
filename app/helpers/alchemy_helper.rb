require 'rubygems'
require 'net/http'
require 'uri'
require 'json'

class AlchemyAPI

  #Setup the endpoints
  @@ENDPOINTS = {}
  @@ENDPOINTS['sentiment'] = {}
  @@ENDPOINTS['sentiment']['url'] = '/url/URLGetTextSentiment'
  @@ENDPOINTS['sentiment']['text'] = '/text/TextGetTextSentiment'
  @@ENDPOINTS['sentiment']['html'] = '/html/HTMLGetTextSentiment'
  @@ENDPOINTS['sentiment_targeted'] = {}
  @@ENDPOINTS['sentiment_targeted']['url'] = '/url/URLGetTargetedSentiment'
  @@ENDPOINTS['sentiment_targeted']['text'] = '/text/TextGetTargetedSentiment'
  @@ENDPOINTS['sentiment_targeted']['html'] = '/html/HTMLGetTargetedSentiment'
  @@ENDPOINTS['author'] = {}
  @@ENDPOINTS['author']['url'] = '/url/URLGetAuthor'
  @@ENDPOINTS['author']['html'] = '/html/HTMLGetAuthor'
  @@ENDPOINTS['keywords'] = {}
  @@ENDPOINTS['keywords']['url'] = '/url/URLGetRankedKeywords'
  @@ENDPOINTS['keywords']['text'] = '/text/TextGetRankedKeywords'
  @@ENDPOINTS['keywords']['html'] = '/html/HTMLGetRankedKeywords'
  @@ENDPOINTS['concepts'] = {}
  @@ENDPOINTS['concepts']['url'] = '/url/URLGetRankedConcepts'
  @@ENDPOINTS['concepts']['text'] = '/text/TextGetRankedConcepts'
  @@ENDPOINTS['concepts']['html'] = '/html/HTMLGetRankedConcepts'
  @@ENDPOINTS['entities'] = {}
  @@ENDPOINTS['entities']['url'] = '/url/URLGetRankedNamedEntities'
  @@ENDPOINTS['entities']['text'] = '/text/TextGetRankedNamedEntities'
  @@ENDPOINTS['entities']['html'] = '/html/HTMLGetRankedNamedEntities'
  @@ENDPOINTS['category'] = {}
  @@ENDPOINTS['category']['url']  = '/url/URLGetCategory'
  @@ENDPOINTS['category']['text'] = '/text/TextGetCategory'
  @@ENDPOINTS['category']['html'] = '/html/HTMLGetCategory'
  @@ENDPOINTS['relations'] = {}
  @@ENDPOINTS['relations']['url']  = '/url/URLGetRelations'
  @@ENDPOINTS['relations']['text'] = '/text/TextGetRelations'
  @@ENDPOINTS['relations']['html'] = '/html/HTMLGetRelations'
  @@ENDPOINTS['language'] = {}
  @@ENDPOINTS['language']['url']  = '/url/URLGetLanguage'
  @@ENDPOINTS['language']['text'] = '/text/TextGetLanguage'
  @@ENDPOINTS['language']['html'] = '/html/HTMLGetLanguage'
  @@ENDPOINTS['text'] = {}
  @@ENDPOINTS['text']['url']  = '/url/URLGetText'
  @@ENDPOINTS['text']['html'] = '/html/HTMLGetText'
  @@ENDPOINTS['text_raw'] = {}
  @@ENDPOINTS['text_raw']['url']  = '/url/URLGetRawText'
  @@ENDPOINTS['text_raw']['html'] = '/html/HTMLGetRawText'
  @@ENDPOINTS['title'] = {}
  @@ENDPOINTS['title']['url']  = '/url/URLGetTitle'
  @@ENDPOINTS['title']['html'] = '/html/HTMLGetTitle'
  @@ENDPOINTS['feeds'] = {}
  @@ENDPOINTS['feeds']['url']  = '/url/URLGetFeedLinks'
  @@ENDPOINTS['feeds']['html'] = '/html/HTMLGetFeedLinks'
  @@ENDPOINTS['microformats'] = {}
  @@ENDPOINTS['microformats']['url']  = '/url/URLGetMicroformatData'
  @@ENDPOINTS['microformats']['html'] = '/html/HTMLGetMicroformatData'
  @@ENDPOINTS['taxonomy'] = {}
  @@ENDPOINTS['taxonomy']['url']  = '/url/URLGetRankedTaxonomy'
  @@ENDPOINTS['taxonomy']['text'] = '/text/TextGetRankedTaxonomy'
  @@ENDPOINTS['taxonomy']['html'] = '/html/HTMLGetRankedTaxonomy'
  @@ENDPOINTS['combined'] = {}
  @@ENDPOINTS['combined']['url'] = '/url/URLGetCombinedData'
  @@ENDPOINTS['combined']['text'] = '/text/TextGetCombinedData'
  @@ENDPOINTS['image_extract'] = {}
  @@ENDPOINTS['image_extract']['url'] = '/url/URLGetImage'
  @@ENDPOINTS['image_tag'] = {}
  @@ENDPOINTS['image_tag']['url'] = '/url/URLGetRankedImageKeywords'
  @@ENDPOINTS['image_tag']['image'] = '/image/ImageGetRankedImageKeywords'
    
  @@BASE_URL = 'http://access.alchemyapi.com/calls'
  
  
  def initialize()
  
    begin
      key = File.read('api_key.txt')
      key.strip!

      if key.empty?
        #The key file should't be blank
        puts 'The api_key.txt file appears to be blank, please copy/paste your API key in the file: api_key.txt'
        puts 'If you do not have an API Key from AlchemyAPI please register for one at: http://www.alchemyapi.com/api/register.html'      
        Process.exit(1)
      end
      
      if key.length != 40
        #Keys should be exactly 40 characters long
        puts 'It appears that the key in api_key.txt is invalid. Please make sure the file only includes the API key, and it is the correct one.'
        Process.exit(1)
      end

      @apiKey = key
    rescue => err
      #The file doesn't exist, so show the message and create the file.
      puts 'API Key not found! Please copy/paste your API key into the file: api_key.txt'
      puts 'If you do not have an API Key from AlchemyAPI please register for one at: http://www.alchemyapi.com/api/register.html'
    
      #create a blank file to hold the key
      File.open("api_key.txt", "w") {}
      Process.exit(1)
    end
  end





  # Calculates the sentiment for text, a URL or HTML.
  # For an overview, please refer to: http://www.alchemyapi.com/products/features/sentiment-analysis/
  # For the docs, please refer to: http://www.alchemyapi.com/api/sentiment-analysis/
  # 
  # INPUT:
  # flavor -> which version of the call, i.e. text, url or html.
  # data -> the data to analyze, either the text, the url or html code.
  # options -> various parameters that can be used to adjust how the API works, see below for more info on the available options.
  # 
  # Available Options:
  # showSourceText -> 0: disabled (default), 1: enabled
  #
  # OUTPUT:
  # The response, already converted from JSON to a Ruby object. 
  #
  def sentiment(flavor, data, options = {})
    unless @@ENDPOINTS['sentiment'].key?(flavor)
      return { 'status'=>'ERROR', 'statusInfo'=>'sentiment analysis for ' + flavor + ' not available' }
    end

    #Add the URL encoded data to the options and analyze
    options[flavor] = data
    return analyze(@@ENDPOINTS['sentiment'][flavor], options)
  end


  # Calculates the targeted sentiment for text, a URL or HTML.
  # For an overview, please refer to: http://www.alchemyapi.com/products/features/sentiment-analysis/
  # For the docs, please refer to: http://www.alchemyapi.com/api/sentiment-analysis/
  #
  # INPUT:
  # flavor -> which version of the call, i.e. text, url or html.
  # data -> the data to analyze, either the text, the url or html code.
  # target -> the word or phrase to run sentiment analysis on.
  # options -> various parameters that can be used to adjust how the API works, see below for more info on the available options.
  # 
  # Available Options:
  # showSourceText  -> 0: disabled, 1: enabled
  #
  # OUTPUT:
  # The response, already converted from JSON to a Ruby object. 
  #
  def sentiment_targeted(flavor, data, target, options = {})
    if target == '' || target == nil
      return { 'status'=>'ERROR', 'statusMessage'=>'targeted sentiment requires a non-null target' }
    end

    unless @@ENDPOINTS['sentiment_targeted'].key?(flavor)
      return { 'status'=>'ERROR', 'statusInfo'=>'targeted sentiment analysis for ' + flavor + ' not available' }
    end

    #Add the URL encoded data and the target to the options and analyze
    options[flavor] = data
    options['target'] = target
    return analyze(@@ENDPOINTS['sentiment_targeted'][flavor], options)
  end


  # Extracts the keywords from text, a URL or HTML.
  # For an overview, please refer to: http://www.alchemyapi.com/products/features/keyword-extraction/
  # For the docs, please refer to: http://www.alchemyapi.com/api/keyword-extraction/
  #
  # INPUT:
  # flavor -> which version of the call, i.e. text, url or html.
  # data -> the data to analyze, either the text, the url or html code.
  # options -> various parameters that can be used to adjust how the API works, see below for more info on the available options.
  #   
  # Available Options:
  # keywordExtractMode -> normal (default), strict
  # sentiment -> analyze sentiment for each keyword. 0: disabled (default), 1: enabled. Requires 1 additional API transaction if enabled.
  # showSourceText -> 0: disabled (default), 1: enabled.
  # maxRetrieve -> the max number of keywords returned (default: 50)
  #
  # OUTPUT:
  # The response, already converted from JSON to a Ruby object. 
  # 
  def keywords(flavor, data, options = {})
    unless @@ENDPOINTS['keywords'].key?(flavor)
      return { 'status'=>'ERROR', 'statusInfo'=>'keyword extraction for ' + flavor + ' not available' }
    end

    #Add the URL encoded data to the options and analyze
    options[flavor] = data
    return analyze(@@ENDPOINTS['keywords'][flavor], options)
  end

  
  # Tags the concepts for text, a URL or HTML.
  # For an overview, please refer to: http://www.alchemyapi.com/products/features/concept-tagging/
  # For the docs, please refer to: http://www.alchemyapi.com/api/concept-tagging/ 
  #
  # Available Options:
  # maxRetrieve -> the maximum number of concepts to retrieve (default: 8)
  # linkedData -> include linked data, 0: disabled, 1: enabled (default)
  # showSourceText -> 0:disabled (default), 1: enabled
  #
  # OUTPUT:
  # The response, already converted from JSON to a Ruby object. 
  #
  def concepts(flavor, data, options = {})
    unless @@ENDPOINTS['concepts'].key?(flavor)
      return { 'status'=>'ERROR', 'statusInfo'=>'concept tagging for ' + flavor + ' not available' }
    end

    #Add the URL encoded data to the options and analyze
    options[flavor] = data
    return analyze(@@ENDPOINTS['concepts'][flavor], options)
  end


  # Categorizes the text for text, a URL or HTML.
  # For an overview, please refer to: http://www.alchemyapi.com/products/features/text-categorization/
  # For the docs, please refer to: http://www.alchemyapi.com/api/text-categorization/
  #
  # INPUT:
  # flavor -> which version of the call, i.e. text, url or html.
  # data -> the data to analyze, either the text, the url or html code.
  # options -> various parameters that can be used to adjust how the API works, see below for more info on the available options.
  #
  # Available Options:
  # showSourceText -> 0: disabled (default), 1: enabled
  # 
  # OUTPUT:
  # The response, already converted from JSON to a Ruby object. 
  #
  def category(flavor, data, options = {})
    unless @@ENDPOINTS['category'].key?(flavor)
      return { 'status'=>'ERROR', 'statusInfo'=>'text categorization for ' + flavor + ' not available' }
    end

    #Add the URL encoded data to the options and analyze
    options[flavor] = data
    return analyze(@@ENDPOINTS['category'][flavor], options)
  end


  # Detects the language for text, a URL or HTML.
  # For an overview, please refer to: http://www.alchemyapi.com/api/language-detection/ 
  # For the docs, please refer to: http://www.alchemyapi.com/products/features/language-detection/
  #
  # INPUT:
  # flavor -> which version of the call, i.e. text, url or html.
  # data -> the data to analyze, either the text, the url or html code.
  # options -> various parameters that can be used to adjust how the API works, see below for more info on the available options.
  #
  # Available Options:
  # none
  #
  # OUTPUT:
  # The response, already converted from JSON to a Ruby object.
  #
  def language(flavor, data, options = {})
    unless @@ENDPOINTS['language'].key?(flavor)
      return { 'status'=>'ERROR', 'statusInfo'=>'language detection for ' + flavor + ' not available' }
    end

    #Add the URL encoded data to the options and analyze
    options[flavor] = data
    return analyze(@@ENDPOINTS['language'][flavor], options)
  end


  # Extracts the cleaned text (removes ads, navigation, etc.) for text, a URL or HTML.
  # For an overview, please refer to: http://www.alchemyapi.com/products/features/text-extraction/
  # For the docs, please refer to: http://www.alchemyapi.com/api/text-extraction/
  # 
  # INPUT:
  # flavor -> which version of the call, i.e. text, url or html.
  # data -> the data to analyze, either the text, the url or html code.
  # options -> various parameters that can be used to adjust how the API works, see below for more info on the available options.
  #
  # Available Options:
  # useMetadata -> utilize meta description data, 0: disabled, 1: enabled (default)
  # extractLinks -> include links, 0: disabled (default), 1: enabled.
  # 
  # OUTPUT:
  # The response, already converted from JSON to a Ruby object. 
  #
  def text(flavor, data, options = {})
    unless @@ENDPOINTS['text'].key?(flavor)
      return { 'status'=>'ERROR', 'statusInfo'=>'clean text extraction for ' + flavor + ' not available' }
    end

    #Add the URL encoded data to the options and analyze
    options[flavor] = data
    return analyze(@@ENDPOINTS['text'][flavor], options)
  end


  # Categorizes the text for a URL, text or HTML.
  # For an overview, please refer to: http://www.alchemyapi.com/products/features/text-categorization/
  # For the docs, please refer to: http://www.alchemyapi.com/api/taxonomy/
  # 
  # INPUT:
  # flavor -> which version of the call, i.e.  url, text or html.
  # data -> the data to analyze, either the the url, text or html code.
  # options -> various parameters that can be used to adjust how the API works, see below for more info on the available options.
  #
  # Available Options:
  # showSourceText -> 0: disabled (default), 1: enabled.
  #
  # OUTPUT:
  # The response, already converted from JSON to a Ruby object. 
  #
  def taxonomy(flavor, data, options = {})
    unless @@ENDPOINTS['taxonomy'].key?(flavor)
      return { 'status'=>'ERROR', 'statusInfo'=>'Taxonomy info for ' + flavor + ' not available' }
    end

    #Add the URL encoded data to the options and analyze
    options[flavor] = data
    return analyze(@@ENDPOINTS['taxonomy'][flavor], options)
  end


  # Combined call (see options below for available extractions) for a URL or text.
  # 
  # INPUT:
  # flavor -> which version of the call, i.e.  url or text.
  # data -> the data to analyze, either the the url or text.
  # options -> various parameters that can be used to adjust how the API works, see below for more info on the available options.
  #
  # Available Options:
  # extract -> VALUE,VALUE,VALUE,... (possible VALUEs: page-image,entity,keyword,title,author,taxonomy,concept,relation,doc-sentiment)
  # extractMode -> (only applies when 'page-image' VALUE passed to 'extract' option) 
  #     trust-metadata: less CPU-intensive, less accurate
  #     always-infer: more CPU-intensive, more accurate
  # disambiguate -> whether to disambiguate detected entities, 0: disabled, 1: enabled (default)
  # linkedData -> whether to include Linked Data content links with disambiguated entities, 0: disabled, 1: enabled (default). disambiguate must be enabled to use this.
  # coreference -> whether to he/she/etc coreferences into detected entities, 0: disabled, 1: enabled (default)
  # quotations -> whether to enable quotations extraction, 0: disabled (default), 1: enabled
  # sentiment -> whether to enable entity-level sentiment analysis, 0: disabled (default), 1: enabled. Requires one additional API transaction if enabled.
  # showSourceText -> 0: disabled (default), 1: enabled.
  # maxRetrieve -> maximum number of named entities to extract (default: 50)
  #
  # OUTPUT:
  # The response, already converted from JSON to a Ruby object. 
  #
  def combined(flavor, data, options = {})
    unless @@ENDPOINTS['combined'].key?(flavor)
      return { 'status'=>'ERROR', 'statusInfo'=>'Combined data for ' + flavor + ' not available' }
    end

    #Add the URL encoded data to the options and analyze
    options[flavor] = data
    return analyze(@@ENDPOINTS['combined'][flavor], options)
  end



  private

  # HTTP Request wrapper that is called by the endpoint functions. This function is not intended to be called through an external interface. 
  # It makes the call, then converts the returned JSON string into a Ruby object. 
  #
  # INPUT:
  # url -> the full URI encoded url
  # 
  # OUTPUT:
  # The response, already converted from JSON to a Ruby object. 
  # 
  def analyze(url, options)

    #Insert the base URL
    url = @@BASE_URL + url

    #Add the API key and set the output mode to JSON
    options['apikey'] = @apiKey
    options['outputMode'] = 'json'

    uri = URI.parse(url)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(options)

    # disable gzip encoding which blows up in Zlib due to Ruby 2.0 bug
    # otherwise you'll get Zlib::BufError: buffer error
    request['Accept-Encoding'] = 'identity'

    #Fire off the HTTP request
    res = Net::HTTP.start(uri.host, uri.port) do |http|
          http.request(request)
      end

    #parse and return the response
    return JSON.parse(res.body)
  end
end



# Writes the API key to api_key.txt file. It will create the file if it doesn't exist.
# This function is intended to be called from the Python command line using: python -c 'import alchemyapi;alchemyapi.setkey("API_KEY");'
# If you don't have an API key yet, register for one at: http://www.alchemyapi.com/api/register.html
# 
# INPUT:
# key -> Your API key from  Should be 40 hex characters
# 
# OUTPUT:
# none
#

if __FILE__==$0
    # this will only run if the script was the main, not load'd or require'd
  if ARGV.length == 1
    if (ARGV[0].length == 40)
      puts 'Key: ' + ARGV[0] + ' was written to api_key.txt'
      puts 'You are now ready to start using AlchemyAPI. For an example, run: ruby example.rb'
      File.open('api_key.txt','w') {|f| f.write(ARGV[0]) }
    else
      puts 'The key appears to invalid. Please make sure to use the 40 character key assigned by AlchemyAPI'
    end
  end

end


