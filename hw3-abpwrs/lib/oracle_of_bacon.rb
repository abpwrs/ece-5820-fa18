# frozen_string_literal: true

# require 'byebug' # optional, may be helpful
require 'open-uri' # allows open('http://...') to return body
require 'cgi' # for escaping URIs
require 'nokogiri' # XML parser
require 'active_model' # for validations


# The  main class for the OracleOfBacon behaviors
class OracleOfBacon
  class InvalidError < RuntimeError
  end
  class NetworkError < RuntimeError
  end
  class InvalidKeyError < RuntimeError
  end

  attr_accessor :from, :to
  attr_reader :api_key, :response, :uri

  include ActiveModel::Validations
  validates_presence_of :from
  validates_presence_of :to
  validates_presence_of :api_key
  validate :from_does_not_equal_to

  def from_does_not_equal_to
    return unless @from.casecmp(@to).zero?
    # add errors for both to and from --> this is redundant, but more fun
    errors.add(:to, 'to cannot equal from')
    errors.add(:from, 'from cannot equal to')
  end

  # set actual api key as the default argument
  def initialize(api_key = '38b99ce9ec87')
    @api_key = api_key
    # set both to default to Kevin Bacon
    @from = 'Kevin Bacon'
    @to = 'Kevin Bacon'
  end

  def find_connections
    # make the uri
    make_uri_from_arguments
    begin
      # attempt to parse uri
      xml = URI.parse(uri).read
    rescue OpenURI::HTTPError
      xml = %q{<?xml version="1.0" standalone="no"?>
<error type="unauthorized">unauthorized use of xml interface</error>}
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
           Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError,
           Net::ProtocolError => e
      # convert all of these into a generic OracleOfBacon::NetworkError,
      #  but keep the original error message
      raise NetworkError, e
    end
    # implicit return of response and set variable
    @response = Response.new(xml)
  end

  def make_uri_from_arguments
    # THIS HAS TO BE HTTP NOT HTTPS --> spent an hour figuring that out :(
    @uri = "http://oracleofbacon.org/cgi-bin/xml?p=#{CGI.escape(@api_key)}&a=#{CGI.escape(@to)}&b=#{CGI.escape(@from)}"
  end

  class Response
    # meta query methods
    attr_reader :type, :data
    # create a Response object from a string of XML markup.
    def initialize(xml)
      @doc = Nokogiri::XML(xml)
      parse_response
    end

    private

    def parse_response
      if !@doc.xpath('/error').empty? # error response
        parse_error_response

      elsif !@doc.xpath('/spellcheck').empty? # spell-check response
        parse_spellcheck_response

      elsif !@doc.xpath('/link').empty? # graph response
        parse_graph_response

      else # unknown
        parse_unknown_response

      end
    end

    def parse_error_response
      error_type = @doc.xpath('/error').attr('type').value
      error_message = @doc.xpath('/error').text
      if error_type == 'unauthorized'
        @type = :unauthorized
        @data = error_message
      elsif error_type == 'badinput'
        @type = :badinput
        @data = error_message
      elsif error_type == 'unlinkable'
        @type = :unlinkable
        @data = error_message
      else
        @type = :unknown
        @data = 'unknown'
      end
    end

    def parse_spellcheck_response
      @type = :spellcheck # set type
      @data = [] # default to list
      @doc.xpath('//match').to_ary.each { |i| @data << i.text } # populate list
    end

    def parse_graph_response
      @type = :graph # set type
      @data = [] # default to list
      @doc.xpath('(//actor | //movie)').to_ary.each { |i| @data << i.text } # populate list
    end

    # As a note, the two above methods could be compressed via the following, which would remove the default assignment
    # @doc.xpath('regex').to_ary.each{|i| (@data ||= []) << i.text}

    def parse_unknown_response
      @type = :unknown # set type
      @data = 'unknown response' # set error data
    end
  end
end
