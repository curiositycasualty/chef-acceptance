module Test
  class Util
    class << self
      def format_to_rsa(rsa)
        # voodoo magic to reformat text return value back into rsa format
        rsa.gsub! (/(-----BEGIN RSA PRIVATE KEY----- )(.*)(-----END RSA PRIVATE KEY-----)/) { |s|
          """#{$1}\n#{$2.tr(' ', "\n")}#{$3}"""
        }
      end
    end
  end
end