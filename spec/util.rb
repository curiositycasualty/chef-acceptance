require 'fileutils'

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
