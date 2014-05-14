require 'fileutils'
require 'rest_client'

class Util
  class << self
    def format_to_rsa(rsa)
      # voodoo magic to reformat text return value back into rsa format
      rsa.gsub! (/(-----BEGIN RSA PRIVATE KEY----- )(.*)(-----END RSA PRIVATE KEY-----)/) { |s|
        """#{$1}\n#{$2.tr(' ', "\n")}#{$3}"""
      }
    end

    def write_pem(org_name, validator_key)
      File.open("#{ENV['CHEF_TEST_DIR']}/work/pems/#{org_name}-validator.pem", "w") do |f|
        f.write "#{validator_key}"
      end
    end
  end
end

class Knife
  @bin = "#{ENV['CHEF_TEST_DIR']}/bin/knife"
  @config = "-c #{ENV['CHEF_TEST_DIR']}/users/chef/.chef/knife.rb"
  class << self
    def upload(subcommand, args = nil)
      system("#{@bin} upload #{@config} #{subcommand} #{args}")
    end

    def node(subcommand, args = nil)
      system("#{@bin} node #{@config} #{subcommand} #{args}")
    end

    def generate_config(org_factory)
    end
  end
end

class Metal
  @bin = "#{ENV['CHEF_TEST_DIR']}/bin/chef-client -z"
  @config = "-c #{ENV['CHEF_TEST_DIR']}/users/chef/.chef/knife.rb"
  class << self
    def run(run_list)
      system("#{@bin} #{@config} -o #{run_list}")
    end
  end
end

class Solr
  class << self
    # copied from pedant
    # https://github.com/opscode/chef-pedant/blob/160dce6e1499c70cf88acea3bc66f86d8303044e/lib/pedant/rspec/search_util.rb#L643-L660
    def force_update
      url = "#{ENV['search_host']}/solr/update"
      body = '<commit waitSearcher="true" waitFlush="true" softCommit="false"/>'
      headers = {
        "Content-Type" => "application/xml",
        "Accept" => "application/xml"
      }
      # assuming we're running this after adding
      # some things to Solr, we want to give it a little
      # time to clear the queue.  In a test scenario, this
      # should be enough of a wait.
      sleep 0.500
      RestClient.send :post, url, body, headers
    end
  end
end
